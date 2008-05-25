From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Documentation: convert tutorials to man pages
Date: Sat, 24 May 2008 18:40:14 -0700
Message-ID: <7vlk1zjh4x.fsf@gitster.siamese.dyndns.org>
References: <20080524205644.f056db96.chriscool@tuxfamily.org>
 <200805250113.m4P1DSCg028065@mi1.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: =?iso-2022-jp?B?GyRCJDckaSQkJDckSiRKJDMbKEI=?= 
	<nanako3@bluebottle.com>, Pieter de Bie <pdebie@ai.rug.nl>,
	Jakub Narebski <jnareb@gmail.com>,
	Manoj Srivastava <srivasta@ieee.org>,
	"Thomas Adam" <thomas.adam22@gmail.com>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun May 25 03:41:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K05Eb-0001kh-TG
	for gcvg-git-2@gmane.org; Sun, 25 May 2008 03:41:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753466AbYEYBk1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 May 2008 21:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752013AbYEYBk1
	(ORCPT <rfc822;git-outgoing>); Sat, 24 May 2008 21:40:27 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46373 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751108AbYEYBk0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 May 2008 21:40:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 647921002;
	Sat, 24 May 2008 21:40:25 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 8D6DB1001; Sat, 24 May 2008 21:40:17 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8C09F08E-29FB-11DD-9EED-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82848>

しらいしななこ  <nanako3@bluebottle.com> writes:

> Christian Couder <chriscool@tuxfamily.org> writes:
>
> However, I think this is much improved, compared to the one around the
> beginning of the month.  Especially that documents like the user manual
> that do not fit well in "manual page" format are excluded.
>
> But if I read intro(1) and intro(7) correctly, nothing other than the
> user commands should go to section 1.  Here is my attempt, as a
> replacement patch, to clean it up.
>
> What do you think?

Christian, I think the amended patch makes more sense (I haven't compared
the two very carefully, though).
