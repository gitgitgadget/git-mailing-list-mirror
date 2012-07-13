From: Edward Toroshchin <edward.hades@gmail.com>
Subject: Re: Don't share anything but those files
Date: Fri, 13 Jul 2012 18:14:51 +0200
Message-ID: <20120713161432.GA8770@phobos>
References: <500037EB.5030408@modusfx.com>
 <20120713152127.GC17521@phobos.chilli.itwm.local>
 <50004048.9060203@modusfx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Yves Perron <yves.perron@modusfx.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 13 18:15:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SpiWH-00041I-Oo
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jul 2012 18:15:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277Ab2GMQO6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jul 2012 12:14:58 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:53449 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756567Ab2GMQO6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2012 12:14:58 -0400
Received: by wgbdr13 with SMTP id dr13so3340920wgb.1
        for <git@vger.kernel.org>; Fri, 13 Jul 2012 09:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=BqjiPopvoFWVb9BY4vPnYVpW/ez80jy2/kMT6YgrizY=;
        b=Y0pdbSVQHXZJ0NiR7KI2P41Yk0clovDFjes5Ar1kF8HhBFqMxXvD/gXEXbAGmzOmtB
         D4Qk1D+Hm7Fsmzxl7Ucgk0CS1v155bXrexhmCkvAkes+CKGY03alI6DBHepvHkgDh9xs
         BeM+p4aRKzdLOJpA5zLIqBnStU3zC62r4Z88O4EjpSPWvhp1xlZOfwvrhgjdhN5n8jR+
         G9jw9ocq9k9ylY5H2MEKyB0emVMDFbjdq/R/EKtJr9TdoVZTx28G954ch/rbGjy1hAPn
         iQpKd7NRjLRF1R3wZNUnZwk9flvN+N3wx8knxzA0A6MFSyRQUp0vQEYwdXmvvAfDuNbW
         bASg==
Received: by 10.180.78.33 with SMTP id y1mr3929037wiw.3.1342196096364;
        Fri, 13 Jul 2012 09:14:56 -0700 (PDT)
Received: from localhost (ganymede.hades.name. [81.17.21.251])
        by mx.google.com with ESMTPS id df4sm4040760wib.4.2012.07.13.09.14.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 13 Jul 2012 09:14:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <50004048.9060203@modusfx.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201409>

On Fri, Jul 13, 2012 at 11:35:36AM -0400, Yves Perron wrote:
> Oh I see, thank you for your response,
> 
> Can I put all the folders/files I want to add in a config file so I 
> don't have to do this every time?
> 
> Thx
> 

You won't have to do this every time. Once you add a file and commit it,
git will track it in the future.

-- 
Edward "Hades" Toroshchin
dr_lepper on irc.freenode.org
