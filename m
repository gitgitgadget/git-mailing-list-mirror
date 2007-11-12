From: "Medve Emilian" <Emilian.Medve@freescale.com>
Subject: RE: [PATCH] Fix a strchrnul() related build error
Date: Mon, 12 Nov 2007 15:12:18 -0700
Message-ID: <598D5675D34BE349929AF5EDE9B03E27017BC128@az33exm24.fsl.freescale.net>
References: <1194901282-2468-1-git-send-email-Emilian.Medve@Freescale.com> <Pine.LNX.4.64.0711122126370.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <gitster@pobox.com>, <ae@op5.se>, <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 12 23:13:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrhWb-00036N-AG
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 23:12:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755215AbXKLWMf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 17:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755281AbXKLWMf
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 17:12:35 -0500
Received: from az33egw01.freescale.net ([192.88.158.102]:33153 "EHLO
	az33egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755108AbXKLWMe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Nov 2007 17:12:34 -0500
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id lACMCJux018998
	for <git@vger.kernel.org>; Mon, 12 Nov 2007 15:12:20 -0700 (MST)
Received: from az33exm24.fsl.freescale.net (az33exm24.am.freescale.net [10.64.32.14])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id lACMCJfM014009
	for <git@vger.kernel.org>; Mon, 12 Nov 2007 16:12:19 -0600 (CST)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <Pine.LNX.4.64.0711122126370.4362@racer.site>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Fix a strchrnul() related build error
thread-index: AcglctGGAik7jra2RNajpKQs7sz6ewABibEg
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64720>

Hi Dscho,

> didn't Johannes Sixt provide a (slightly nicer) patch earlier today?

That is nicer and should go into the tree.


Cheers,
Emil.
