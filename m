From: Jarek Poplawski <jarkao2@gmail.com>
Subject: gitweb: history link doesn't work properly
Date: Wed, 20 Jan 2010 12:08:25 +0000
Message-ID: <20100120120825.GB6225@ff.dom.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 20 13:08:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXZMR-0000nE-Vz
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 13:08:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752504Ab0ATMIa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 07:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261Ab0ATMI3
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 07:08:29 -0500
Received: from mail-fx0-f225.google.com ([209.85.220.225]:63334 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181Ab0ATMI2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 07:08:28 -0500
Received: by fxm25 with SMTP id 25so467403fxm.21
        for <multiple recipients>; Wed, 20 Jan 2010 04:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=bi/DSTOwgwkSf+l2ZERgTi6zr9TxexI6nosSsOiGEnQ=;
        b=F+8eePgn9DwFVHXDTXnkr/o6DFeIKUN8jkLVl+e02uW0Gs7c435+TGOQltykvWU0ow
         Q5YdyKaaierPQIRmTSJmoAh9zuUdvHzI+rOF1+fFTu3sAXHca3LSt1Sbu3H5xt59UsZb
         qaOfqo/863CLEapM/eF1+Yd57YOd+FX/ycfhA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=HNJDBdUM+rfVApwUDfNLUfEBlMAtfc/4Adn538+UD9zPuN8ZIwTBjw36QBefS9oVpm
         FYu/za1DL1WMr88pTiEJatBMYIKGJ/4xqg4kilklvqU8fICa1AO33OPm75TwXAKc+QTD
         w6YZW0fD+SLHhPfkAEPP7BPv17MHZGBluNGuw=
Received: by 10.223.14.194 with SMTP id h2mr3845984faa.14.1263989307059;
        Wed, 20 Jan 2010 04:08:27 -0800 (PST)
Received: from ff.dom.local (bv170.internetdsl.tpnet.pl [80.53.205.170])
        by mx.google.com with ESMTPS id b17sm9510042fka.46.2010.01.20.04.08.26
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 20 Jan 2010 04:08:26 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137546>

Hi,

Clicking _history_ at Linus's or other git.kernel.org tree doesn't
show history of a file/directory any more (probably sth fresh).

Regards,
Jarek P.
