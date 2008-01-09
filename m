From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: Update and fix Makefile
Date: Wed, 9 Jan 2008 14:43:07 +1100
Message-ID: <18308.17099.334609.80415@cargo.ozlabs.ibm.com>
References: <200801082154.21282.stimming@tuhh.de>
	<7vk5mkq669.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Christian Stimming <stimming@tuhh.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 04:44:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCRrc-0001El-TH
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 04:44:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753077AbYAIDnd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 22:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752926AbYAIDnc
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 22:43:32 -0500
Received: from ozlabs.org ([203.10.76.45]:35639 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754847AbYAIDnb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 22:43:31 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 0BE4BDDF05; Wed,  9 Jan 2008 14:43:30 +1100 (EST)
In-Reply-To: <7vk5mkq669.fsf@gitster.siamese.dyndns.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69950>

Junio C Hamano writes:

> I see somwhat funny spacing there.  I'd suggest giving up
> aligning with spaces and consistently saying "var ?= val"
> instead.

I made those lines all have one space before and after the ?=, and
committed Christian's patches (plus one from Gerrit Pape), and pushed
it out.  Please do a pull.

Paul.
