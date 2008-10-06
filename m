From: "Dilip M" <dilipm79@gmail.com>
Subject: Re: how to restrict commit for a repo
Date: Mon, 6 Oct 2008 22:42:06 +0530
Message-ID: <c94f8e120810061012p29210247sfd3c1b3c05e871ee@mail.gmail.com>
References: <c94f8e120810060509w5eaa9138m92f1df36c9c36db6@mail.gmail.com>
	 <20081006130042.GQ23137@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Miklos Vajna" <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Oct 06 19:18:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmteA-0001g0-65
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 19:13:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753472AbYJFRMN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 13:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753449AbYJFRMN
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 13:12:13 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:40473 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753319AbYJFRMM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 13:12:12 -0400
Received: by gxk9 with SMTP id 9so5246211gxk.13
        for <git@vger.kernel.org>; Mon, 06 Oct 2008 10:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=mPM/wJ0ATrF8/frf1nkePbyUGjkvNCxFmN7OW0uZNmI=;
        b=ry7TkSwJw4KjYCYu1Yui/xhjemv21631UiNBocHYpg90/AmokCxZViIwsk++tUOU+6
         VT56VrKie7wS07bgQu1MCTzQBkcCQ07wU94wRUMDx3fCrDgGDAXaqN7O9soAL+85ARXP
         zesuN998ut3rQhUJuxmRJBqcC4mGBKAuJhASY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=L+eaMOZzvUFzSDIMmUN6vh3ODGxemNmxxpM+K1oKvxOxZNqelbQA6yB+mIqcZQflHf
         g7hneev7t5rR7Zx9NacvsB15JM40UIFF9SQBQ/AUjopsGkll4nmicXDqXmOZlMkq+H+Z
         LGyxTpRKVyRNgFf1ZWMaJmAO7w3M3VJsTd6js=
Received: by 10.90.100.20 with SMTP id x20mr6018396agb.85.1223313126926;
        Mon, 06 Oct 2008 10:12:06 -0700 (PDT)
Received: by 10.90.52.15 with HTTP; Mon, 6 Oct 2008 10:12:06 -0700 (PDT)
In-Reply-To: <20081006130042.GQ23137@genesis.frugalware.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97605>

2008/10/6 Miklos Vajna <vmiklos@frugalware.org>:
> On Mon, Oct 06, 2008 at 05:39:39PM +0530, Dilip M <dilipm79@gmail.com> wrote:
>> If I have a repository, how to prevent push from other repo's into
>> mine master's? I want to prevent the commits from all developers and
>> allow only few ppl to commit to masters..
>
> Have you seen contrib/hooks/update-paranoid?

Miklos,  I am totally new to this tool ( don't know SVN too) . Can you
please consider giving some more info...or guiding me to some good
links...:)

Thanks in advance..

-- 
dm
