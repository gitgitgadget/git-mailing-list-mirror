From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH v2] cvsserver: Fix for histories with multiple roots
Date: Sun, 27 Jan 2008 10:47:15 +0100
Message-ID: <359E2AFB-50AA-470E-9FE3-C78805037AAA@zib.de>
References: <7v8x2cyqsg.fsf@gitster.siamese.dyndns.org> <12014266292347-git-send-email-prohaska@zib.de>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jan 27 10:51:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJ4Aj-0001B3-3j
	for gcvg-git-2@gmane.org; Sun, 27 Jan 2008 10:51:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757557AbYA0Jua (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2008 04:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757548AbYA0Ju3
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jan 2008 04:50:29 -0500
Received: from mailer.zib.de ([130.73.108.11]:42527 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756065AbYA0JuV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2008 04:50:21 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m0R9kF6h020781;
	Sun, 27 Jan 2008 10:49:45 +0100 (CET)
Received: from [192.168.178.21] (brln-4db92972.pool.einsundeins.de [77.185.41.114])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m0R9kEn1026763
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 27 Jan 2008 10:46:15 +0100 (MET)
In-Reply-To: <12014266292347-git-send-email-prohaska@zib.de>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71812>


On Jan 27, 2008, at 10:37 AM, Steffen Prohaska wrote:

> Junio,
> here is a replacement for the second patch.  Different from your diff,
> I replaced tabs with 8 spaces because all of the surrounding code
> uses spaces for indentation.

Ah... too late... I should have pulled first ;)

Anyway; thanks for improving the first version.

	Steffen
