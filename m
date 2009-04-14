From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC3 05/13] send-email: Cleanup the usage text and docs a
  bit
Date: Mon, 13 Apr 2009 22:39:11 -0700
Message-ID: <7vfxgbaj5s.fsf@gitster.siamese.dyndns.org>
References: <1239647037-15381-1-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-2-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-3-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-4-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-5-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-6-git-send-email-mfwitten@gmail.com>
 <7vhc0se0pc.fsf@gitster.siamese.dyndns.org>
 <b4087cc50904131542q7354fa05wb763f70e4baf9abb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 07:41:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtbO6-0006K5-DM
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 07:40:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751649AbZDNFjS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2009 01:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbZDNFjS
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 01:39:18 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56155 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263AbZDNFjR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2009 01:39:17 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D356AAA418;
	Tue, 14 Apr 2009 01:39:15 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D1FEFAA417; Tue,
 14 Apr 2009 01:39:12 -0400 (EDT)
In-Reply-To: <b4087cc50904131542q7354fa05wb763f70e4baf9abb@mail.gmail.com>
 (Michael Witten's message of "Mon, 13 Apr 2009 17:42:45 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 977D43B6-28B6-11DE-94D3-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116514>

Michael Witten <mfwitten@gmail.com> writes:

>>> A port number in --smtp-server is no longer handled,
>>> so the suggestion has been removed.
> ...
> I may have been concerned that the SSL connection code doesn't support
> a host:port specification, so I thought it would be easier not to
> advertise it:

These two statements contradict with each other.  Please make up your mind
;-).
