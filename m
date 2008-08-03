From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] hash-object --no-filters
Date: Sun, 03 Aug 2008 13:44:27 -0700
Message-ID: <7vod49u8us.fsf@gitster.siamese.dyndns.org>
References: <200807311257.49108.litvinov2004@gmail.com>
 <20080731104529.GE7008@dpotapov.dyndns.org>
 <200808011023.32139.litvinov2004@gmail.com>
 <37fcd2780808010047t4ae20168y65103e90897dd3f8@mail.gmail.com>
 <7vbq0dtawp.fsf@gitster.siamese.dyndns.org>
 <37fcd2780808010224l68c2c717y5334a34d9de1de8d@mail.gmail.com>
 <7vmyjwserv.fsf@gitster.siamese.dyndns.org>
 <20080801220932.GK7008@dpotapov.dyndns.org>
 <7vmyjvnx76.fsf_-_@gitster.siamese.dyndns.org>
 <20080803054218.GM7008@dpotapov.dyndns.org>
 <20080803055602.GN7008@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexander Litvinov <litvinov2004@gmail.com>, git@vger.kernel.org,
	Eric Wong <normalperson@yhbt.net>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 03 22:45:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPkSS-0001As-4w
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 22:45:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754914AbYHCUoi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 16:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755345AbYHCUoi
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 16:44:38 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37296 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754381AbYHCUoh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 16:44:37 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B49154861A;
	Sun,  3 Aug 2008 16:44:34 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 26BBD48600; Sun,  3 Aug 2008 16:44:30 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FB24CCE0-619C-11DD-B942-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91268>

Very nicely done; will queue along with the 5 patch series.

Thanks.
