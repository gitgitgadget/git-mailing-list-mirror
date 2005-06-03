From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: qgit-0.3
Date: Fri, 03 Jun 2005 13:55:09 +1000
Message-ID: <1117770909.31082.121.camel@gaston>
References: <20050601111949.90043.qmail@web26303.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, berkus@gmail.com
X-From: git-owner@vger.kernel.org Fri Jun 03 05:53:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1De3F4-0003Gh-RH
	for gcvg-git@gmane.org; Fri, 03 Jun 2005 05:53:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbVFCD4G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Jun 2005 23:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbVFCD4G
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jun 2005 23:56:06 -0400
Received: from gate.crashing.org ([63.228.1.57]:1493 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261203AbVFCD4D (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jun 2005 23:56:03 -0400
Received: from gaston (localhost [127.0.0.1])
	by gate.crashing.org (8.12.8/8.12.8) with ESMTP id j533lvZn015500;
	Thu, 2 Jun 2005 22:47:58 -0500
To: Marco Costalba <mcostalba@yahoo.it>
In-Reply-To: <20050601111949.90043.qmail@web26303.mail.ukl.yahoo.com>
X-Mailer: Evolution 2.2.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 2005-06-01 at 13:19 +0200, Marco Costalba wrote:
> New version of qgit, the QT/C++ git viewer.
> 
> Download at:
> 
> http://prdownloads.sourceforge.net/qgit/qgit-0.3.tar.gz?download
> 
> This time we use scons instead of qmake as build system (many thanks to Stanislav Karchebny), I
> hope people have less problems compiling it.
> 
> As before just run make and copy the bin in the path.
> 
> New feature is async loading of diff and file blobs, should be much faster navigate the logs with
> secondary windows (double click on logs or file names to show) opened.

I spent 1/2h and never managed to build it. When it doesn't find some
includes, it doesn't look for some Qt related binaries in the right
path, or whatever, it's just basically unbuildable.

Ben.


