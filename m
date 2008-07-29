From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge-base: die with an error message if not passed a
 commit ref
Date: Mon, 28 Jul 2008 22:45:00 -0700
Message-ID: <7vzlo1kzvn.fsf@gitster.siamese.dyndns.org>
References: <20080729074253.b4617027.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Jul 29 07:46:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNi2M-00029f-O6
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 07:46:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753471AbYG2FpL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 01:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753264AbYG2FpL
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 01:45:11 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57020 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753436AbYG2FpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 01:45:09 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6CDE941FB5;
	Tue, 29 Jul 2008 01:45:09 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C14E441FB4; Tue, 29 Jul 2008 01:45:02 -0400 (EDT)
In-Reply-To: <20080729074253.b4617027.chriscool@tuxfamily.org> (Christian
 Couder's message of "Tue, 29 Jul 2008 07:42:53 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 81417DC0-5D31-11DD-A84C-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90581>

Thanks; queued for 1.6.0.
