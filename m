From: Jonas Fonseca <jonas.fonseca@gmail.com>
Subject: Re: [JGIT] Request for help
Date: Fri, 4 Sep 2009 08:41:07 -0400
Message-ID: <2c6b72b30909040541t4c781378g3f35aeb70021050c@mail.gmail.com>
References: <loom.20090904T064602-511@post.gmane.org> <554991.93608.qm@web27807.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Gabe McArthur <gabriel.mcarthur@gmail.com>
To: Mark Struberg <struberg@yahoo.de>
X-From: git-owner@vger.kernel.org Fri Sep 04 14:41:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjY6t-0000ej-30
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 14:41:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755737AbZIDMlZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 08:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756773AbZIDMlZ
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 08:41:25 -0400
Received: from mail-iw0-f175.google.com ([209.85.223.175]:61647 "EHLO
	mail-iw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753432AbZIDMlY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 08:41:24 -0400
Received: by iwn5 with SMTP id 5so211115iwn.4
        for <git@vger.kernel.org>; Fri, 04 Sep 2009 05:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=CXM/91clsOEiGdd05TK0eQ9yJcwDcfEb4XvExJc4lHw=;
        b=lngpbXj3A6wTKP5ZLoYqclOdzXhjQslHYVgEv8EFunxEp9fkpQ9wpi3MpWkA7XMvj5
         mOke7lBdwuOmv58649mrYjw/6neear0JOCfVMF+CsFfvmhoQgkEI1GSCLm6wJSkRmXDJ
         q7yEk4iKdocGpTKN//C+b5Iz5NfgGNP32MGLk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=hLSqtHJ4ECYBgKfNNCUoB8k8TDLSqdWz1SYAPY1llvRYG/Gq9/GzHmHF6mjbD6XERb
         JtSKU39rEXL9rW2UsjKKGsdQdjaU0X2J+oIj9epGwq+m7NL17RMMRAmZmjA3hMqAZnn+
         457E2M+B/QUiRo5CTrCPm3NFo8qTQERaZQEcU=
Received: by 10.231.24.208 with SMTP id w16mr9909749ibb.38.1252068087070; Fri, 
	04 Sep 2009 05:41:27 -0700 (PDT)
In-Reply-To: <554991.93608.qm@web27807.mail.ukl.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127728>

On Fri, Sep 4, 2009 at 03:33, Mark Struberg<struberg@yahoo.de> wrote:
>> From: Gabe McArthur <gabriel.mcarthur@gmail.com>
> >
>> I'll try to submit a full patch later, using your
>> conventions.

I have a question as well:

Support for using find bug is part of the Eclipse configuration (see
org.spearce.jgit/findBugs/), and I know that there's a find bug plugin
for Maven. From looking at sonatype's JGit repositories it is not
integrated. Have you managed to include it?

-- 
Jonas Fonseca
