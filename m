From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: Make project specific override for 'grep'
 feature work
Date: Sun, 07 Dec 2008 02:52:48 -0800
Message-ID: <7vljuscl4v.fsf@gitster.siamese.dyndns.org>
References: <20081207052230.GD4357@ftbfs.org>
 <20081207093447.25785.41811.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matt Kraai <kraai@ftbfs.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 07 11:54:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9HHV-0004IH-CP
	for gcvg-git-2@gmane.org; Sun, 07 Dec 2008 11:54:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753333AbYLGKwz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Dec 2008 05:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753319AbYLGKwz
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Dec 2008 05:52:55 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51440 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753296AbYLGKwz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Dec 2008 05:52:55 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 648A5184F0;
	Sun,  7 Dec 2008 05:52:54 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1F1E9184EF; Sun, 
 7 Dec 2008 05:52:49 -0500 (EST)
In-Reply-To: <20081207093447.25785.41811.stgit@localhost.localdomain> (Jakub
 Narebski's message of "Sun, 07 Dec 2008 10:36:36 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 33594AA6-C44D-11DD-A374-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102495>

Thanks, both.  This should go to maint, right?
