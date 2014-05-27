From: Johan Herland <johan@herland.net>
Subject: Re: Best practices/conventions for tags and references in commit message
Date: Tue, 27 May 2014 15:49:24 +0200
Message-ID: <CALKQrgfYfXyXs0K+tq6xXNaQ-J1VdwJ7iodyE3s8X8wHN8WuvA@mail.gmail.com>
References: <201405271326.36031.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>
To: Thomas Koch <thomas@koch.ro>
X-From: git-owner@vger.kernel.org Tue May 27 15:49:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpHl0-0006zm-BX
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 15:49:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752158AbaE0Nta (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 09:49:30 -0400
Received: from mail12.copyleft.no ([188.94.218.224]:60929 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066AbaE0Nta (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 09:49:30 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1WpHku-0001R6-1J
	for git@vger.kernel.org; Tue, 27 May 2014 15:49:28 +0200
Received: from mail-ob0-f173.google.com ([209.85.214.173])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1WpHkt-000GTy-O0
	for git@vger.kernel.org; Tue, 27 May 2014 15:49:27 +0200
Received: by mail-ob0-f173.google.com with SMTP id wm4so9289778obc.18
        for <git@vger.kernel.org>; Tue, 27 May 2014 06:49:24 -0700 (PDT)
X-Received: by 10.182.43.132 with SMTP id w4mr33035066obl.41.1401198564188;
 Tue, 27 May 2014 06:49:24 -0700 (PDT)
Received: by 10.182.245.10 with HTTP; Tue, 27 May 2014 06:49:24 -0700 (PDT)
In-Reply-To: <201405271326.36031.thomas@koch.ro>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250166>

Search the mailing list archives for git-interpret-trailers. It's coming. :)


...Johan

On Tue, May 27, 2014 at 1:26 PM, Thomas Koch <thomas@koch.ro> wrote:
> Hi,
>
> different projects or tools have conventions to include machine parsable
> information in commit messages, e.g.:
>
> Closes: #42
> Thanks: my mother, my wife
> Git-Dch: Ignore
> Commit-Id: 50M3R34LLYR4ND0MB1TSANDNUMB3R5
>
> (see thread: "RFE: support change-id generation natively" for Commit-Id)
> ("Git-Dch: Ignore" ecludes the commit from the changelog)
>
> Are you aware of any convention or best practices for such tags that are used
> in more than one project? Are there more tags like these?
>
> Maybe it would also be helpful to have some more plumbing support from Git for
> such tags. But I've not yet thought enough about this.
>
> Best regards, Thomas Koch
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Johan Herland, <johan@herland.net>
www.herland.net
