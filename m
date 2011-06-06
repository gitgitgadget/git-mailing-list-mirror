From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv3 1/5] gitweb: Move information about installation from
 README to INSTALL
Date: Mon, 6 Jun 2011 14:44:44 -0500
Message-ID: <20110606194422.GA30588@elie>
References: <1307382271-7677-1-git-send-email-jnareb@gmail.com>
 <1307382271-7677-2-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>,
	Drew Northup <drew.northup@maine.edu>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 06 21:44:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTfjO-0006Xt-DT
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 21:44:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754042Ab1FFTox (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 15:44:53 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41530 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753509Ab1FFTow (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 15:44:52 -0400
Received: by iyb14 with SMTP id 14so3375262iyb.19
        for <git@vger.kernel.org>; Mon, 06 Jun 2011 12:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=5eoJTY5F9eIN7D/5M21Ktv2THvtW1qC39e/RJnzf3To=;
        b=LH93IBLA1psA6WfoSo5Rh+gSPndH+p7AOz4/fEnO9jTXxRuen0iSGZyTxtagqGwRpj
         2CKLNFSdUMpuw9iT1azZeJorytNdAbPVZ/9XeJQH/5k7vy3PNmN5pR5fJOkhdHURoG6M
         SOBn8o+lH4CR4HVsovKLrp5yePIrx9aXv/kYE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=sdCqr5D+/Vio51l22GUpY1RMMMZOEjfdQdIuz2oI1YdIz5VbS/FT1c1R++2jr7iKjk
         sHS7e8zjfGpkJXOzKKyazP4QvtsYcydpDsXgjn/UnxHZnXR7x8YWhaCnmdnxE6u7YfvH
         B0CW0bGjIl6CACL5mNx1ds6wakf/qolU4vwWY=
Received: by 10.42.219.65 with SMTP id ht1mr9358516icb.14.1307389491789;
        Mon, 06 Jun 2011 12:44:51 -0700 (PDT)
Received: from elie (adsl-68-255-97-40.dsl.chcgil.sbcglobal.net [68.255.97.40])
        by mx.google.com with ESMTPS id d8sm2948024icy.21.2011.06.06.12.44.49
        (version=SSLv3 cipher=OTHER);
        Mon, 06 Jun 2011 12:44:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1307382271-7677-2-git-send-email-jnareb@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175152>

Jakub Narebski wrote:

> Almost straightformard moving of "How to configure gitweb for your
> local system" section from gitweb/README to gitweb/INSTALL, as it is
> about build time configuration.  Updated references to it.
>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>

s/Updated/Update/.  The patch is obviously good; thanks for taking
care of it.
