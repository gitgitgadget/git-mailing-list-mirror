From: Janos Laube <janos.dev@gmail.com>
Subject: Re: [msysGit] Re: Git for Windows 1.6.2-preview20090308
Date: Sun, 8 Mar 2009 22:36:06 +0100
Message-ID: <9d6091530903081436k20591bdbu69cd73ed2f1c98b5@mail.gmail.com>
References: <alpine.DEB.1.00.0903080132470.10279@pacific.mpi-cbg.de>
	 <46d6db660903081430m35da0d2eoc97377dfec54b1b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes.Schindelin@gmx.de, git@vger.kernel.org,
	msysgit@googlegroups.com
To: christian.michon@gmail.com
X-From: git-owner@vger.kernel.org Sun Mar 08 22:37:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgQgl-0007DA-2n
	for gcvg-git-2@gmane.org; Sun, 08 Mar 2009 22:37:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754219AbZCHVgM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2009 17:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754092AbZCHVgL
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Mar 2009 17:36:11 -0400
Received: from mail-fx0-f176.google.com ([209.85.220.176]:34350 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753051AbZCHVgK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2009 17:36:10 -0400
Received: by fxm24 with SMTP id 24so1029642fxm.37
        for <git@vger.kernel.org>; Sun, 08 Mar 2009 14:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=991+YX3DlG5FFTnnYMoS2A4uO7cJES1XSqj3ldXFik8=;
        b=kqJwt6DYo3M7O3dHHl3VehwP85PPT8DJdTCc5/XtQ4A5vAwZkKe1DGRp0NpdbGy71W
         HJQJkFA8QGJtOsH3S9crk5A50t04amQHwtGSee0kNHTz0FCablasfwYjg+xXc7FMIB/W
         Q2Tfnkl5/fneZzjfXhgCn3zUaYvoFhTlksgIM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FqfqOjR7OAq00l/X3tl92OLL0n3ksh0sf5q5awTFmqoInuD2fRArVVEOwZNFofWnXt
         N05UdtSeW6axhNyhRRjsSf0257593LOKRntmj04Ib3ctK0AVKgFX9a9yWdtGo3SIsPw2
         hhjj/c1zRzxDEedlh17b0Sb6S4DBGY5nLrZwQ=
Received: by 10.180.239.8 with SMTP id m8mr1758751bkh.165.1236548166626; Sun, 
	08 Mar 2009 14:36:06 -0700 (PDT)
In-Reply-To: <46d6db660903081430m35da0d2eoc97377dfec54b1b5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112648>

> I'll look at what could be wrong right now.

as vim says, the syntax files in /share/vim/vim72/syntax are missing,
i.e. not included with the installer package :-)
