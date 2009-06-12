From: "Aaron Gray" <aaronngray.lists@googlemail.com>
Subject: Native Windows implementation of GIT ?
Date: Fri, 12 Jun 2009 23:07:54 +0100
Message-ID: <2A554044B82841D594338E2E096804BC@HPLAPTOP>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 13 00:08:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFEuu-0005vJ-EE
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 00:08:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757911AbZFLWH7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 18:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752903AbZFLWH6
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 18:07:58 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:61110 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752269AbZFLWH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 18:07:57 -0400
Received: by ewy6 with SMTP id 6so3379127ewy.37
        for <git@vger.kernel.org>; Fri, 12 Jun 2009 15:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:subject
         :date:mime-version:content-type:content-transfer-encoding:x-priority
         :x-msmail-priority:x-mailer:x-mimeole;
        bh=UlcN+XUoQdrNLF17CcGq42CYXHfdwQ5IyPLGfQGK2gI=;
        b=AxjE9ET03ZgNILvpTpg2gmshNe+R7KSUp45qskd37iVDLFE6YEoU4QeiPF1qzchsZe
         /6Ex5XrQahsDkWHO2s5iEyoVZ9PNUG7QZhHIkAELvsduhZenJKpeJl1a/9bqhM4p9TD5
         D0uQJBKY3vavIeI5aMPHDJiOEBr1QymVDA5XU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:from:to:subject:date:mime-version:content-type
         :content-transfer-encoding:x-priority:x-msmail-priority:x-mailer
         :x-mimeole;
        b=DaACkx8mNCRTEQ7LzuzYRPn+DTYoBODR01Sg4Yh+RDKJl4/VMtAkY1LZuFj/iL7UL5
         MOcoVSPomDHK+wqPFaalFNc8nB0nOSd9adzLllMRHuk5bH80tWiMLOCrU/Jff97l1/Pi
         oaYJZofln8M++Gu+HSCuzKuZ75gdFw3Un1XmI=
Received: by 10.210.56.2 with SMTP id e2mr2303630eba.18.1244844479112;
        Fri, 12 Jun 2009 15:07:59 -0700 (PDT)
Received: from HPLAPTOP (mwgray.force9.co.uk [212.159.110.144])
        by mx.google.com with ESMTPS id 23sm501708eya.39.2009.06.12.15.07.58
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 12 Jun 2009 15:07:58 -0700 (PDT)
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5512
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.5579
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121456>

Is there going to be a native Windows implementation of GIT ?

i.e. not MSYS or Cygwin based.

Many thanks in advance,

Aaron
