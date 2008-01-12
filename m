From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] GIT 1.5.4-rc3
Date: Sat, 12 Jan 2008 00:04:22 -0800
Message-ID: <7vr6gnv5a1.fsf@gitster.siamese.dyndns.org>
References: <7vsl13wmas.fsf@gitster.siamese.dyndns.org>
	<200801120926.14307.ismail@pardus.org.tr>
	<7vejcnwl85.fsf@gitster.siamese.dyndns.org>
	<200801120947.48602.ismail@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ismail =?utf-8?Q?D=C3=B6nmez?= <ismail@pardus.org.tr>
X-From: git-owner@vger.kernel.org Sat Jan 12 09:04:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDbMQ-0005vs-CI
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 09:04:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759719AbYALIE3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 03:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759542AbYALIE3
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 03:04:29 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45276 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759312AbYALIE2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 03:04:28 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 95EE04C6E;
	Sat, 12 Jan 2008 03:04:27 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 38F8F4C6D;
	Sat, 12 Jan 2008 03:04:25 -0500 (EST)
In-Reply-To: <200801120947.48602.ismail@pardus.org.tr> (Ismail =?utf-8?Q?D?=
 =?utf-8?Q?=C3=B6nmez's?=
	message of "Sat, 12 Jan 2008 09:47:48 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70295>

Please do not run build nor test as root.
