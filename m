From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: [PATCH] Add subcommand "help" to the list of most commonly used subcommands
Date: Thu, 5 Jun 2008 20:38:02 +0200
Message-ID: <408F1687-FC42-4E96-B641-088F200CE8D1@ai.rug.nl>
References: <alpine.DEB.1.00.0806050747000.21190@racer> <20080605081911.GA5946@mithlond.arda.local> <7viqwn3g3r.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Teemu Likonen <tlikonen@iki.fi>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 20:39:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4KMb-0006vf-JU
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 20:39:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753718AbYFESiM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 14:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754012AbYFESiM
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 14:38:12 -0400
Received: from smtp-3.orange.nl ([193.252.22.243]:20165 "EHLO smtp-3.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751334AbYFESiL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 14:38:11 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6203.orange.nl (SMTP Server) with ESMTP id A962F1C000A0;
	Thu,  5 Jun 2008 20:38:09 +0200 (CEST)
Received: from [192.168.1.11] (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6203.orange.nl (SMTP Server) with ESMTP id 65F381C0009C;
	Thu,  5 Jun 2008 20:38:03 +0200 (CEST)
X-ME-UUID: 20080605183807417.65F381C0009C@mwinf6203.orange.nl
In-Reply-To: <7viqwn3g3r.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83951>


On 5 jun 2008, at 20:13, Junio C Hamano wrote:

> See 'man git' and 'git help' for more information.

I'd like to see something more like

See 'git help COMMAND' for more information on a specific command


- Pieter
