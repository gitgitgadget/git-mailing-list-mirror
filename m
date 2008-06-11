From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: [PATCH v3] builtin-fast-export: Add importing and exporting of revision marks
Date: Wed, 11 Jun 2008 13:24:59 +0200
Message-ID: <3BC2A14C-720C-4E78-B226-852AA28A3EE7@ai.rug.nl>
References: <7vve0hdbvv.fsf@gitster.siamese.dyndns.org> <1213183024-60013-1-git-send-email-pdebie@ai.rug.nl>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Git Mailinglist <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 11 13:26:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6OSr-0004CU-Ta
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 13:26:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752670AbYFKLZL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 07:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752682AbYFKLZK
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 07:25:10 -0400
Received: from smtp-3.orange.nl ([193.252.22.243]:58245 "EHLO smtp-3.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751678AbYFKLZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 07:25:09 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6201.orange.nl (SMTP Server) with ESMTP id A01171C00085;
	Wed, 11 Jun 2008 13:25:08 +0200 (CEST)
Received: from [192.168.1.11] (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6201.orange.nl (SMTP Server) with ESMTP id 423CB1C00083;
	Wed, 11 Jun 2008 13:25:00 +0200 (CEST)
X-ME-UUID: 20080611112506271.423CB1C00083@mwinf6201.orange.nl
In-Reply-To: <1213183024-60013-1-git-send-email-pdebie@ai.rug.nl>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84603>


On 11 jun 2008, at 13:17, Pieter de Bie wrote:

> +	cp tmp-marks ~ &&

but beware this stray line.
