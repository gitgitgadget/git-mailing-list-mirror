From: David Michael Barr <david.barr@cordelta.com>
Subject: Re: [PATCH svn-dump-fast-export] Reference documentation
Date: Sat, 29 May 2010 16:59:18 +1000
Message-ID: <9DEABC23-A416-4099-BF01-B9ACFC3284F7@cordelta.com>
References: <20100529061621.GA6513@progeny.tock>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 29 08:59:37 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIG16-0001NA-Ib
	for gcvg-git-2@lo.gmane.org; Sat, 29 May 2010 08:59:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751932Ab0E2G7Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 May 2010 02:59:25 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:41460 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811Ab0E2G7Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 May 2010 02:59:24 -0400
Received: by pwj2 with SMTP id 2so74459pwj.19
        for <git@vger.kernel.org>; Fri, 28 May 2010 23:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=n6bU+XN5qy4W3Ttf6JmtD6uXXArAsQ97z/9APogOK8A=;
        b=JEjtEh5nC8qifZ7zBsMaBuJuh8H7bEXYz1MDSDeb5h7pjuWdVHQW2gLt80Yk1JAjoO
         00sIYSe10HV1T7F4LX9MpWrbqX/3u6WiPCTL38YPl6yy+GDSPbvOPnj9YSkgFkbgslKa
         2niScXB3aHc6k/Y6iFrPpdzooKZTRSMApxypI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=mFFwWNJPWg2uy3Ccg3uGHe6O3s6StxB40HqxGqcgXY3muB1WBbl8WwZFlkQRPrQBXZ
         EiO6J8pywIY5NEQGVjhz7+IPNLFEeDetddTZ7/CURPDd7W3DETTxIzNdJrJ72NcU+6hH
         gK6SLm32whpSCfoFwuhFDBVyxxH3X2041uj90=
Received: by 10.142.55.4 with SMTP id d4mr964457wfa.309.1275116363636;
        Fri, 28 May 2010 23:59:23 -0700 (PDT)
Received: from [192.168.1.2] (d122-109-106-179.mit3.act.optusnet.com.au [122.109.106.179])
        by mx.google.com with ESMTPS id d16sm26690584wam.12.2010.05.28.23.59.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 28 May 2010 23:59:23 -0700 (PDT)
In-Reply-To: <20100529061621.GA6513@progeny.tock>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147957>

Hi,

> Add a simple manual page (in asciidoc format) to document
> the svn-fe command.
> 
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Patch is against git://github.com/barrbrain/svn-dump-fast-export.git master

This patch has now been accepted into that repository.

> Thoughts?

Couldn't have done it better myself.

Incremental dump support is still a TODO.

--
David Barr
