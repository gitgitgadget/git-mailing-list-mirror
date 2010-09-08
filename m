From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Fix for normalization of foreign idents
Date: Tue, 7 Sep 2010 23:32:28 -0500
Message-ID: <20100908043227.GD24444@capella.cs.uchicago.edu>
References: <1282599032-11369-1-git-send-email-marcus@mc.pp.se> <20100823213531.GD2120@burratino> <yf97hjhrol5.fsf@chiyo.mc.pp.se> <yf9vd6j5hti.fsf@mc.pp.se> <20100906210719.GD26371@burratino> <yf9sk1l73bt.fsf@chiyo.mc.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Marcus Comstedt <marcus@mc.pp.se>
X-From: git-owner@vger.kernel.org Wed Sep 08 06:33:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtCLC-0004Is-BE
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 06:32:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410Ab0IHEcn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Sep 2010 00:32:43 -0400
Received: from camembert.cs.uchicago.edu ([128.135.164.153]:39587 "EHLO
	smtp.cs.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946Ab0IHEc3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Sep 2010 00:32:29 -0400
Received: from capella.cs.uchicago.edu (capella.cs.uchicago.edu [128.135.24.228])
	by smtp.cs.uchicago.edu (Postfix) with ESMTP id 9F40CB92C;
	Tue,  7 Sep 2010 23:32:28 -0500 (CDT)
Received: by capella.cs.uchicago.edu (Postfix, from userid 10442)
	id 2C2E8A7CA; Tue,  7 Sep 2010 23:32:28 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <yf9sk1l73bt.fsf@chiyo.mc.pp.se>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155765>

Marcus Comstedt wrote:

> Ok.  I'll shortly post an updated patch with some test cases.

Thanks.

> As for documentation, I suppose that would mean documenting the
> "foreign ident" concept as a whole, as I don't think there's currently
> anything about that in the documentation?  Would the `ident` section
> of gitattributes.txt be a suitable place for this?

Yep, that sounds good (though by no means necessary either).
