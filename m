Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: (qmail 17971 invoked by uid 111); 4 Aug 2008 16:48:29 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 04 Aug 2008 12:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757505AbYHDQsG (ORCPT <rfc822;peff@peff.net>);
	Mon, 4 Aug 2008 12:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757930AbYHDQsF
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 12:48:05 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:34005 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757959AbYHDQsE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 12:48:04 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1213811ywe.1
        for <git@vger.kernel.org>; Mon, 04 Aug 2008 09:48:04 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=sp9VNT7km6wEVduwdXZKDtw66VAd9FYtUnF/sHaZ4oE=;
        b=Uf/qfFeIdttSSAoSC9o374T+CsVrvKhtVG/t4sYWdPkxYeBjYZfwNz8cDvUndGiMtN
         ZTm3FyrGdw6t20hgEMGQ4lBeB89pUx6ORZH6MkSlWJtD+8VMXxNpT7jllPz4zV6O1NaY
         2KYiJxR6QuVJJ1NPtfugTvYx/rlfdLYLaw/mk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=SX2eMIS/OxrXyHNnCul4+uBk2Os3Ja4zGgVcYGE3TrR7voypnFjw5Cwsp7hQ7FJS7Z
         Q6KZlk3krpJM8xNOIfyN4XIzUles2iGt604rldgDdXP1ZIBYGgnxYUy5uUShJO2X1oRt
         JC0LjTx5dC/YH+D1PlEbEBK9uQZX+8ZOeeUXg=
Received: by 10.103.242.7 with SMTP id u7mr5718879mur.125.1217868482731;
        Mon, 04 Aug 2008 09:48:02 -0700 (PDT)
Received: by 10.102.244.9 with HTTP; Mon, 4 Aug 2008 09:48:02 -0700 (PDT)
Message-ID: <5dfc0b810808040948x6cd1f29fhaf2bf85a09cfd404@mail.gmail.com>
Date:	Mon, 4 Aug 2008 12:48:02 -0400
From:	"James Linder" <james.h.linder@gmail.com>
To:	git@vger.kernel.org
Subject: NYU Open Source Programming Class Releases JavaGit API 0.1.0 Alpha
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hello Git Developers and Users,

This summer, New York University held a class called Open Source
Programming.  One of the projects to come out of the class is JavaGit,
an API providing access to git repositories for Java applications.
Today the JavaGit team has released version 0.1.0 Alpha of the JavaGit
API.  The announcement is listed below.

We are looking forward to continuing the project and grow the project
and welcome new volunteers.  So if the project sounds interesting,
check it out and let us know what you think.

Regards,

The JavaGit Team

------------------------------------------------------------
JavaGit Releases Version 0.1.0 Alpha - August 4, 2008

The JavaGit team is pleased to announce the release of JavaGit version
0.1.0 alpha, an API providing access to git repositories from Java
programs. The goal of JavaGit is to bring the power of git to the Java
developer as an API that is intuitive for developers new to git and
developers who are veteran git users.

JavaGit is engineered to provide the developer with access to the raw
git commands through a command API as well as an object API designed
to represent the .git repository, the working tree and other, familiar
git concepts. JavaGit uses the git binaries installed on the host
machine to provide git functionality and has been designed to easily
accommodate additional methods of access to git repositories.

JavaGit is released as open source software under the GNU LGPL license.

For additional information on the JavaGit project, please visit:

   http://www.javagit.com
