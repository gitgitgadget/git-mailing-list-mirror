From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH v5 00/28] Support multiple checkouts
Date: Mon, 7 Jul 2014 20:32:45 +0300
Message-ID: <20140707173245.GA10530@wheezy.local>
References: <1393675983-3232-1-git-send-email-pclouds@gmail.com>
 <1394246900-31535-1-git-send-email-pclouds@gmail.com>
 <20140706204651.GB21237@wheezy.local>
 <CACsJy8D=9vVkZ2PtZq=b6R6wEmr1pX-yxCCXVBrd-akfeqE1sQ@mail.gmail.com>
 <1404730141.4779.25.camel@seahawk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Mon Jul 07 19:33:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4Cn1-0007My-Tf
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jul 2014 19:33:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbaGGRdP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2014 13:33:15 -0400
Received: from p3plsmtpa09-09.prod.phx3.secureserver.net ([173.201.193.238]:39603
	"EHLO p3plsmtpa09-09.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751020AbaGGRdO (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Jul 2014 13:33:14 -0400
Received: from wheezy.local ([82.181.158.170])
	by p3plsmtpa09-09.prod.phx3.secureserver.net with 
	id PVYx1o00A3gsSd601VZCLU; Mon, 07 Jul 2014 10:33:14 -0700
Content-Disposition: inline
In-Reply-To: <1404730141.4779.25.camel@seahawk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252974>

On Mon, Jul 07, 2014 at 12:49:01PM +0200, Dennis Kaarsemaker wrote:
> I do intend to use checkout --to and submodule update on the same
> repository, but have not yet done so. I will poke at that later this
> month. If you can easily reproduce errors, I would appreciate to know
> how, because my use of submodules is very limited.

I have collected all my tests to this script:
https://raw.githubusercontent.com/max630/git/tmp/multiple_work_trees_dev/t/t7410-submodule-checkout-to.sh

-- 
Max
