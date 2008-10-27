From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add mksnpath and git_snpath which allow to specify the
 output buffer
Date: Sun, 26 Oct 2008 22:07:24 -0700
Message-ID: <7v8wsak4mr.fsf@gitster.siamese.dyndns.org>
References: <20081026215913.GA18594@blimp.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 27 06:08:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuKLU-00051o-IK
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 06:08:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbYJ0FHi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2008 01:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbYJ0FHi
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 01:07:38 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49547 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369AbYJ0FHi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 01:07:38 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B011074789;
	Mon, 27 Oct 2008 01:07:36 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 40E2A74784; Mon, 27 Oct 2008 01:07:31 -0400 (EDT)
In-Reply-To: <20081026215913.GA18594@blimp.localdomain> (Alex Riesen's
 message of "Sun, 26 Oct 2008 22:59:13 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2BB4CC9A-A3E5-11DD-AECE-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99202>

Where is git_snpath() used?
