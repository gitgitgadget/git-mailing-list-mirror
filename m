From: Jakub Narebski <jnareb@gmail.com>
Subject: Google Summer of Code 2007 progress report / summary
Date: Mon, 3 Sep 2007 03:09:30 +0200
Message-ID: <200709030309.30996.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 03 03:09:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IS0Rf-0008VE-SP
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 03:09:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752511AbXICBJe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 21:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752499AbXICBJe
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 21:09:34 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:30796 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754AbXICBJd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 21:09:33 -0400
Received: by nf-out-0910.google.com with SMTP id f5so1094106nfh
        for <git@vger.kernel.org>; Sun, 02 Sep 2007 18:09:32 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=rlKnHJkSIPg1HtURtvWRZlXMlWSkDhHZFevKub6NHimI6RDwDzz/tx0iDZ6AdTODQfcrr3KQVmfH9xzBurVuvYe3oMvQzNbABj50mdzgKgnsopb4XwIVYJ7TcVHo6yzkda5LQTjoteL5aWiX9oCmxFCH5xvjvfgXpAB7Fgx1FAI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=h7c6xmQWlgTSIeiP/D7r7x6CawZzMsQyykTFWoRy9ieP3uVnH8Gek2ukbrHUWN3Za7D/QdLPE3chWV0iEYbTBibeozycn0hnJUmn4QLhMe9Bkdt2P+Pc1+yo+LF0i2WONTxeVoxYCbWxo46lO6HwH2xp5VbyE+/KgIJlDoYNp4c=
Received: by 10.86.71.1 with SMTP id t1mr2965398fga.1188781771790;
        Sun, 02 Sep 2007 18:09:31 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id k29sm4836293fkk.2007.09.02.18.09.29
        (version=SSLv3 cipher=OTHER);
        Sun, 02 Sep 2007 18:09:30 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57421>

How it goes with Google Summer of Code git projects:
builtinification and libification? Which parts are
done, which parts are worked on?

-- 
Jakub Narebski
Poland
