From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tutorial.txt renamed
Date: Tue, 06 Jan 2009 22:27:13 -0800
Message-ID: <7vljtnbpha.fsf@gitster.siamese.dyndns.org>
References: <20090107042337.GA24735@gnu.kitenet.net>
 <200901070628.38019.chriscool@tuxfamily.org>
 <DA6E1A83-FFBA-46BC-9BCF-ED8A2D8F12E7@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Joey Hess <joey@kitenet.net>, git@vger.kernel.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Wed Jan 07 07:28:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKRuE-0000zC-Iv
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 07:28:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752120AbZAGG1X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 01:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752049AbZAGG1W
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 01:27:22 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58705 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810AbZAGG1W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 01:27:22 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1316C8E0D6;
	Wed,  7 Jan 2009 01:27:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0DD2C8E0D3; Wed,
  7 Jan 2009 01:27:14 -0500 (EST)
In-Reply-To: <DA6E1A83-FFBA-46BC-9BCF-ED8A2D8F12E7@silverinsanity.com> (Brian
 Gernhardt's message of "Wed, 7 Jan 2009 00:36:26 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3C8D280A-DC84-11DD-B5EE-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104761>

Brian Gernhardt <benji@silverinsanity.com> writes:

> This is the README file for the project, so it should advise looking  
> at the Documentation directory as neither the man pages or git command  
> are likely installed at this point.

I think that is a sane suggestion.  It is better to keep the number of
prerequisites to the minimum for the user in order to follow README (and
INSTALL, of course).
