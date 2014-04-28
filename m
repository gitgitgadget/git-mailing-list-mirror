From: Jeremy Morton <admin@game-point.net>
Subject: Re: Recording the current branch on each commit?
Date: Mon, 28 Apr 2014 09:52:36 +0100
Message-ID: <535E16D4.9040509@game-point.net>
References: <535C47BF.2070805@game-point.net>	<CALKQrgfmBByMwMhxu3HkJqJGWy2Rwvij6Hi1_4npjfsxcSgpaQ@mail.gmail.com>	<535D4085.4040707@game-point.net> <CALKQrgemFx=2JaC1BaRqCwEV+knC8QftxcZ7K0AsT9azzuyVdA@mail.gmail.com> <535DBD35.4080507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 10:52:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WehIm-0008FB-4X
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 10:52:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754195AbaD1Iwe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 04:52:34 -0400
Received: from mail.gooeysoftware.com ([208.100.15.213]:54203 "EHLO
	mail.gooeysoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753652AbaD1Iwc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 04:52:32 -0400
Received: from [192.168.0.2] (82-69-83-224.dsl.in-addr.zen.co.uk [82.69.83.224])
	by mail.gooeysoftware.com (Postfix) with ESMTPSA id A6ED818A09AC;
	Mon, 28 Apr 2014 04:00:20 -0500 (CDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
In-Reply-To: <535DBD35.4080507@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247249>

On 28/04/2014 03:30, Sitaram Chamarty wrote:
> On 04/28/2014 01:03 AM, Johan Herland wrote:
>> Yeah, sure. Author and Date (and Committer, for that matter) is just
>> metadata, and the current branch name is simply just another kind of
>> metadata. All of them are more-or-less free-form text fields, and off
>
> no they're not. In strictly controlled environments they form part of
> the audit record for the source code.
>
> Yes they can be faked (explicitly), but -- again in strictly controlled
> environments -- that can be limited to "before it was first pushed".

Why these specific headers as part of the audit record, though?  Aren't 
you just arbitrarily defining them as part of the audit record?

-- 
Best regards,
Jeremy Morton (Jez)
