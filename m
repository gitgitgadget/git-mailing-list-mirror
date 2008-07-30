From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH v4 1/2] merge-base: teach "git merge-base" to accept
 more than 2 arguments
Date: Tue, 29 Jul 2008 23:00:34 -0700
Message-ID: <7vy73j9ail.fsf@gitster.siamese.dyndns.org>
References: <20080730070414.f7b36eec.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Jul 30 08:01:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KO4kt-0000wl-FZ
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 08:01:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752488AbYG3GAq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 02:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752500AbYG3GAq
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 02:00:46 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58182 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752383AbYG3GAo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 02:00:44 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3D2A942C85;
	Wed, 30 Jul 2008 02:00:43 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E85B742C81; Wed, 30 Jul 2008 02:00:36 -0400 (EDT)
In-Reply-To: <20080730070414.f7b36eec.chriscool@tuxfamily.org> (Christian
 Couder's message of "Wed, 30 Jul 2008 07:04:14 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D841BE48-5DFC-11DD-8C44-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90749>

Thanks; queued.  Perhaps I'll add the test scirpt to demonstrate the
topology in the new documentation myself, and the merge-octupos update I
sent earlier to the list can come on top of this series.
