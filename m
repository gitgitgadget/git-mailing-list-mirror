From: Marco Costalba <mcostalba@yahoo.it>
Subject: qgit-0.3
Date: Wed, 1 Jun 2005 13:19:49 +0200 (CEST)
Message-ID: <20050601111949.90043.qmail@web26303.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: berkus@gmail.com
X-From: git-owner@vger.kernel.org Wed Jun 01 13:18:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdRDs-0008EY-QV
	for gcvg-git@gmane.org; Wed, 01 Jun 2005 13:17:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbVFALT6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Jun 2005 07:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261285AbVFALT6
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jun 2005 07:19:58 -0400
Received: from web26303.mail.ukl.yahoo.com ([217.146.176.14]:7553 "HELO
	web26303.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261266AbVFALTu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2005 07:19:50 -0400
Received: (qmail 90045 invoked by uid 60001); 1 Jun 2005 11:19:49 -0000
Received: from [151.42.53.52] by web26303.mail.ukl.yahoo.com via HTTP; Wed, 01 Jun 2005 13:19:49 CEST
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

New version of qgit, the QT/C++ git viewer.

Download at:

http://prdownloads.sourceforge.net/qgit/qgit-0.3.tar.gz?download

This time we use scons instead of qmake as build system (many thanks to Stanislav Karchebny), I
hope people have less problems compiling it.

As before just run make and copy the bin in the path.

New feature is async loading of diff and file blobs, should be much faster navigate the logs with
secondary windows (double click on logs or file names to show) opened.

Have fun
Marco



	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
