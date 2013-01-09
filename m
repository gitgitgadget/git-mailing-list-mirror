From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: git branch case insensitivity (Possible bug)
Date: Wed, 09 Jan 2013 19:34:31 +0100
Message-ID: <50EDB837.2070106@kdbg.org>
References: <CAL+iW28LdnNiho4KksLX_S_-+bKX+77GPJ0zqQfkz4JpBJRskw@mail.gmail.com> <50ED925B.2060402@op5.se> <CAL+iW2-eTtMnn65HN9zeFBFXubgkCA7RwVRZjkq7+tRpPk1TGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
To: Alexander Gallego <gallego.alexx@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 19:34:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tt0UJ-0007ne-1U
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 19:34:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106Ab3AISef (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 13:34:35 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:11581 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758023Ab3AISef (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 13:34:35 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 4F7A110014;
	Wed,  9 Jan 2013 19:34:32 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 72EB319F456;
	Wed,  9 Jan 2013 19:34:31 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <CAL+iW2-eTtMnn65HN9zeFBFXubgkCA7RwVRZjkq7+tRpPk1TGg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213076>

Am 09.01.2013 18:03, schrieb Alexander Gallego:
> On Wed, Jan 9, 2013 at 10:52 AM, Andreas Ericsson <ae@op5.se> wrote:
>> [about case-insensitivity of HFS+ and branch names]
>> If you said "yes" to all of the above, this is a filesystem "feature",
>> courtesy of (cr)Apple, and you're screwed.
>>
>> You can work around it by running "git pack-refs" every time you create
>> a branch or a tag though.
> 
> Thanks for the tips. I'll be sure to use this.

Naah... that's unworkable. I'm sure the Andreas meant the suggestion
tongue-in-cheek. The important part of his reply is "you're screwed".

-- Hannes
