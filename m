From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH 1/1] Make git archive respect core.autocrlf when
	creating zip format archives
Date: Thu, 18 Sep 2008 21:08:11 +0100
Message-ID: <20080918200811.GA9101@hashpling.org>
References: <1a7cc4db062b7df0dae0f27b29dba66c9d917e59.1221767629.git.charles@hashpling.org> <20080918200120.GB8631@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 18 22:10:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgPp5-00066J-6b
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 22:09:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756654AbYIRUIP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 16:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755570AbYIRUIP
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 16:08:15 -0400
Received: from ptb-relay03.plus.net ([212.159.14.147]:32996 "EHLO
	ptb-relay03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755842AbYIRUIP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 16:08:15 -0400
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by ptb-relay03.plus.net with esmtp (Exim) id 1KgPnQ-0003Cy-Fe; Thu, 18 Sep 2008 21:08:12 +0100
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id m8IK8CB1009542
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 18 Sep 2008 21:08:12 +0100
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id m8IK8BaW009541;
	Thu, 18 Sep 2008 21:08:11 +0100
Content-Disposition: inline
In-Reply-To: <20080918200120.GB8631@hashpling.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Plusnet-Relay: be43256ab0302c14b62a418fc36fecd2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96240>

Apologies for the bad threading headers and the weird characters in
the subject.

While I though I'd remembered how git format-patch and my mail client
worked together, it's obvious that I hadn't.

I'll make sure that I get it right in the final patch, but in the mean
time are there any comments on this?

Charles.
