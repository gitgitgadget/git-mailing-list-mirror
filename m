From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH] Fix quoting of redirect in test script
Date: Fri, 4 Dec 2015 21:39:44 +0000
Message-ID: <20151204213944.GA14137@hashpling.org>
References: <1449089407-14921-1-git-send-email-charles@hashpling.org>
 <xmqqzixprkkv.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 04 22:47:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4yCM-0000vK-QT
	for gcvg-git-2@plane.gmane.org; Fri, 04 Dec 2015 22:47:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755026AbbLDVrW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2015 16:47:22 -0500
Received: from avasout05.plus.net ([84.93.230.250]:54061 "EHLO
	avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754837AbbLDVrW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2015 16:47:22 -0500
X-Greylist: delayed 454 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Dec 2015 16:47:22 EST
Received: from hashpling.plus.com ([212.159.69.125])
	by avasout05 with smtp
	id pZfk1r0032iA9hg01ZflBA; Fri, 04 Dec 2015 21:39:45 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=MryvkDue c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17 a=EBOSESyhAAAA:8
 a=0Bzu9jTXAAAA:8 a=Ew9TdX-QAAAA:8 a=kj9zAlcOel0A:10 a=wUQvQvOEmiQA:10
 a=BNFp--SqAAAA:8 a=njmtkMF5q5T7lqvHgisA:9 a=CjuIK1q_8ugA:10 a=_enM8AW9c0IA:10
 a=dpRVaBJ5KDsA:10
Received: from charles by hashpling.plus.com with local (Exim 4.84)
	(envelope-from <charles@hashpling.plus.com>)
	id 1a4y4u-0003hA-O0; Fri, 04 Dec 2015 21:39:44 +0000
Content-Disposition: inline
In-Reply-To: <xmqqzixprkkv.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282009>

On Fri, Dec 04, 2015 at 01:05:20PM -0800, Junio C Hamano wrote:
> Do you want to sign-off this patch?
> 
> Thanks.

Oops, yes please.

Signed-off-by: Charles Bailey <cbailey32@bloomberg.net>
