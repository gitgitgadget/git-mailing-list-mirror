From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: How to use git-fmt-merge-msg?
Date: Thu, 5 Feb 2009 14:35:57 +0100
Message-ID: <adf1fd3d0902050535y631035b6lfc09e0982aefdfd7@mail.gmail.com>
References: <84B3CCAA-A044-4517-B2C8-14D5DD754FD2@manchester.ac.uk>
	 <adf1fd3d0902050459s4fcb914ai2b9c8c04e9f72b02@mail.gmail.com>
	 <B22C0229-47F4-48EC-9C68-63696C7BB3F2@manchester.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Robert Haines <rhaines@manchester.ac.uk>
X-From: git-owner@vger.kernel.org Thu Feb 05 14:37:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LV4Q4-0002xm-TX
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 14:37:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755967AbZBENgB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Feb 2009 08:36:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755928AbZBENgB
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 08:36:01 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:61283 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754954AbZBENgA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Feb 2009 08:36:00 -0500
Received: by fxm13 with SMTP id 13so382140fxm.13
        for <git@vger.kernel.org>; Thu, 05 Feb 2009 05:35:58 -0800 (PST)
Received: by 10.103.229.12 with SMTP id g12mr212767mur.16.1233840958079; Thu, 
	05 Feb 2009 05:35:58 -0800 (PST)
In-Reply-To: <B22C0229-47F4-48EC-9C68-63696C7BB3F2@manchester.ac.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108560>

2009/2/5 Robert Haines <rhaines@manchester.ac.uk>:
>
> On 5 Feb 2009, at 12:59, Santi B=E9jar wrote:
>

[...]

>>
>> Manpage of git merge:
>>      --log
>>          In addition to branch names, populate the log message with
>> one-line
>>          descriptions from the actual commits that are being merged.
>>
>> Manpage of git config:
>>      merge.log
>>          Whether to include summaries of merged commits in newly cre=
ated
>>          merge commit messages. False by default.
>
> Aaaahhhh.... Time for me to upgrade. The version of git I am using (1=
=2E5.3.8)
> doesn't have merge --log. No wonder I couldn't find it!

In that version you can use --summary and merge.summary, but they are
now deprecated.

HTH,
Santi
