From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-merge-recursive: honor merge.conflictstyle once
 again
Date: Sun, 19 Oct 2008 14:50:12 -0700
Message-ID: <7vmyh05k6j.fsf@gitster.siamese.dyndns.org>
References: <1224376850.19061.1.camel@mattlaptop2.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matt McCutchen <matt@mattmccutchen.net>
X-From: git-owner@vger.kernel.org Mon Oct 20 11:12:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrgBS-0003gI-Hz
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 23:51:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751898AbYJSVuW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2008 17:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751890AbYJSVuW
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Oct 2008 17:50:22 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60989 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751874AbYJSVuV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2008 17:50:21 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 67C7C8D729;
	Sun, 19 Oct 2008 17:50:19 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 9B17B8D724; Sun, 19 Oct 2008 17:50:14 -0400 (EDT)
In-Reply-To: <1224376850.19061.1.camel@mattlaptop2.local> (Matt McCutchen's
 message of "Sat, 18 Oct 2008 20:40:50 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EC2B1BBE-9E27-11DD-BD3F-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98631>

Matt McCutchen <matt@mattmccutchen.net> writes:

> This was originally implemented in c236bcd06138bcbc929b86ad1a513635bf4847b2
> but was lost to a mismerge in 9ba929ed652f5ed7707f1c684999af4ad02c4925.

Good eyes; thanks.
