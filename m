From: "Sohn, Matthias" <matthias.sohn@sap.com>
Subject: RE: [JGIT PATCH 1/7] Fix FindBugs exclude filter to work on UNIX platforms
Date: Wed, 6 May 2009 13:18:54 +0200
Message-ID: <366BBB1215D0AB4B8A153AF047A28780030C8A5C@dewdfe18.wdf.sap.corp>
References: <1241479848-20687-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>,
	"Robin Rosenberg" <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed May 06 13:19:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1f9e-0005bH-S3
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 13:19:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757205AbZEFLTE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 07:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756535AbZEFLTD
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 07:19:03 -0400
Received: from smtpde03.sap-ag.de ([155.56.68.140]:64237 "EHLO
	smtpde03.sap-ag.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754240AbZEFLTB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 May 2009 07:19:01 -0400
Received: from mail.sap.corp
	by smtpde03.sap-ag.de (26) with ESMTP id n46BIusX011309
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 6 May 2009 13:18:56 +0200 (MEST)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <1241479848-20687-1-git-send-email-spearce@spearce.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [JGIT PATCH 1/7] Fix FindBugs exclude filter to work on UNIX platforms
Thread-Index: AcnNEF/7esfUqXQtSyy54Cl2vbyRNgBK6lrg
X-OriginalArrivalTime: 06 May 2009 11:18:56.0224 (UTC) FILETIME=[71F87E00:01C9CE3C]
X-Scanner: Virus Scanner virwal05
X-SAP: out
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118337>

Shawn O. Pearce [mailto:spearce@spearce.org] wrote:
> Subject: [JGIT PATCH 1/7] Fix FindBugs exclude filter to work on UNIX
> platforms
Thanks, I missed this. I reported this problem to FindBugs :
https://sourceforge.net/tracker/index.php?func=detail&aid=2787728&group_id=96405&atid=614693

--
Matthias
