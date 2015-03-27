From: Tony Finch <dot@dotat.at>
Subject: Re: [PATCH 5/5] gitweb: make category headings into links when they are directories
Date: Fri, 27 Mar 2015 00:14:08 +0000
Message-ID: <28AB00ED-7EA7-43C1-84BE-BD290E09318F@dotat.at>
References: <5e56772f50d3d1498361d8831c4f2fba38d197b4.1426779553.git.dot@dotat.at> <alpine.LSU.2.00.1503191540020.23307@hermes-1.csi.cam.ac.uk> <xmqqwq23y1xl.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Luben Tuikov <ltuikov@yahoo.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 27 01:14:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbHuk-0002Of-W6
	for gcvg-git-2@plane.gmane.org; Fri, 27 Mar 2015 01:14:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752510AbbC0AON (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2015 20:14:13 -0400
Received: from ppsw-32.csi.cam.ac.uk ([131.111.8.132]:49213 "EHLO
	ppsw-32.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752252AbbC0AOM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Mar 2015 20:14:12 -0400
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from host86-129-223-215.range86-129.btcentralplus.com ([86.129.223.215]:54130 helo=[192.168.1.107])
	by ppsw-32.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.156]:587)
	with esmtpsa (PLAIN:fanf2) (TLSv1:DHE-RSA-AES256-SHA:256)
	id 1YbHua-0003DL-2u (Exim 4.82_3-c0e5623)
	(return-path <fanf2@hermes.cam.ac.uk>); Fri, 27 Mar 2015 00:14:08 +0000
X-Mailer: iPhone Mail (12D508)
In-Reply-To: <xmqqwq23y1xl.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266357>


> On 26 Mar 2015, at 19:49, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Any comments from those who use or have their own code in Gitweb on
> this topic?

Thanks for chasing up my patches. I should have written a covering letter, to say that you can see these patches in action at https://git.csx.cam.ac.uk/x/ucs/ - try clicking on the category headings, and observe the pathinfo, breadcrumbs, and links under the search box.

Tony.
-- 
f.anthony.n.finch  <dot@dotat.at>  http://dotat.at