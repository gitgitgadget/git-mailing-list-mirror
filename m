From: "Medve Emilian" <Emilian.Medve@freescale.com>
Subject: git-daemon
Date: Mon, 19 Nov 2007 14:13:12 -0700
Message-ID: <598D5675D34BE349929AF5EDE9B03E27017BCC42@az33exm24.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 19 22:13:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuDvy-0006eq-Ga
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 22:13:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538AbXKSVNR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 16:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbXKSVNR
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 16:13:17 -0500
Received: from de01egw01.freescale.net ([192.88.165.102]:60214 "EHLO
	de01egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411AbXKSVNQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Nov 2007 16:13:16 -0500
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id lAJLDDwb027708
	for <git@vger.kernel.org>; Mon, 19 Nov 2007 14:13:13 -0700 (MST)
Received: from az33exm24.fsl.freescale.net (az33exm24.am.freescale.net [10.64.32.14])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id lAJLDCKS027541
	for <git@vger.kernel.org>; Mon, 19 Nov 2007 15:13:12 -0600 (CST)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: git-daemon
thread-index: Acgq8P05e4SmV1crRtq0pfx5OnmN4A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65501>

Hello,


It seems that something changed since maint/v.1.5.3.6 such that on
master and next git-daemon doesn't seem to be working anymore in inetd
mode. Can somebody please confirm this?


Thanks,
Emil.
