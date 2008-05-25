From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Documentation: convert tutorials to man pages
Date: Sat, 24 May 2008 18:29:30 -0700
Message-ID: <7v4p8nkw79.fsf@gitster.siamese.dyndns.org>
References: <20080524205644.f056db96.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pieter de Bie <pdebie@ai.rug.nl>,
	Jakub Narebski <jnareb@gmail.com>,
	Manoj Srivastava <srivasta@ieee.org>,
	"Thomas Adam" <thomas.adam22@gmail.com>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun May 25 03:30:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K054J-0008QH-A1
	for gcvg-git-2@gmane.org; Sun, 25 May 2008 03:30:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753732AbYEYB3t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 May 2008 21:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754839AbYEYB3s
	(ORCPT <rfc822;git-outgoing>); Sat, 24 May 2008 21:29:48 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44861 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753677AbYEYB3s (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 May 2008 21:29:48 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 456452BB7;
	Sat, 24 May 2008 21:29:44 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 8DE752BB6; Sat, 24 May 2008 21:29:37 -0400 (EDT)
In-Reply-To: <20080524205644.f056db96.chriscool@tuxfamily.org> (Christian
 Couder's message of "Sat, 24 May 2008 20:56:44 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0DE5EE16-29FA-11DD-8A0E-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82846>

Christian Couder <chriscool@tuxfamily.org> writes:

> This patch renames the following documents and at the same time converts
> them to the man page format:
>
> cvs-migration.txt -> gitcvs-migration.txt
> tutorial.txt      -> gittutorial.txt
> tutorial-2.txt    -> gittutorial-2.txt
>
> These new man pages are put in section 1.

Hmmm.  Perhaps these "miscellany information" belong to seciton 7?
