From: Thomas Quinot <thomas@quinot.org>
Subject: Re: [PATCH v2 1/2] git_connect: set ssh shell command in GIT_SSH_CMD
Date: Sun, 9 Nov 2014 18:47:38 +0100
Message-ID: <20141109174738.GA58680@melamine.cuivre.fr.eu.org>
References: <20141108104439.GA89717@melamine.cuivre.fr.eu.org>
 <20141108110958.GB20750@peff.net>
 <20141108123554.GA90057@melamine.cuivre.fr.eu.org>
 <20141108142753.GA28652@melamine.cuivre.fr.eu.org>
 <20141109095155.GB17369@peff.net>
 <20141109123934.GA50956@melamine.cuivre.fr.eu.org>
 <xmqq389se0up.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 09 18:47:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnWad-0008Ue-CR
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 18:47:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbaKIRrr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2014 12:47:47 -0500
Received: from houdart.cuivre.fr.eu.org ([81.57.40.110]:56862 "EHLO
	melamine.cuivre.fr.eu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751274AbaKIRrq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2014 12:47:46 -0500
Received: by melamine.cuivre.fr.eu.org (Postfix, from userid 1000)
	id 9F66B32249; Sun,  9 Nov 2014 18:47:38 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <xmqq389se0up.fsf@gitster.dls.corp.google.com>
X-message-flag: WARNING! Using Outlook can damage your computer.
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

* Junio C Hamano, 2014-11-09 :

> Whatever.  I loathe the CMD abbreviation, though.  Why spell out
> SHELL but not COMMAND?  I.e. GIT_SSH_[SHELL_]COMMAND

No strong opinion :-) GIT_SSH_COMMAND looks just fine to me.
(GIT_SSH_SHELL_COMMAND starts to feel a bit long...)
 
Thomas.
