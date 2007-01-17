From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Git config file reader in Perl (WIP)
Date: Wed, 17 Jan 2007 20:22:51 +0100
Message-ID: <200701172022.52015.jnareb@gmail.com>
References: <200701150144.56793.jnareb@gmail.com> <Pine.LNX.4.63.0701162337330.22628@wbgn013.biozentrum.uni-wuerzburg.de> <dbfc82860701171008r65006b60vf81df9f82ab25712@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Junio C Hamano" <junkio@cox.net>,
	"Eric Wong" <normalperson@yhbt.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 17 20:22:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7GMi-0008Ng-Cz
	for gcvg-git@gmane.org; Wed, 17 Jan 2007 20:22:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932662AbXAQTW0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Jan 2007 14:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932663AbXAQTWZ
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 14:22:25 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:21841 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932662AbXAQTWY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jan 2007 14:22:24 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2070129uga
        for <git@vger.kernel.org>; Wed, 17 Jan 2007 11:22:22 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=D7jeiUx1gH+vV9lcuEPF/nSRHnPibfti21Lz7VW/bDtR27lSwGhpbUoTn7mWLom+ok03kRjZPDz1lm67DLQX6Chg1sJsaP86nxRtwSYAQpeNRD4WZZZBzdgvxbGPwLJm4rtH35iSd/jMaq8b0Xlgo+ntX+epRD0csA0ZAGjf+4w=
Received: by 10.67.100.17 with SMTP id c17mr9037035ugm.1169061742632;
        Wed, 17 Jan 2007 11:22:22 -0800 (PST)
Received: from host-81-190-20-200.torun.mm.pl ( [81.190.20.200])
        by mx.google.com with ESMTP id 20sm8950469uga.2007.01.17.11.22.22;
        Wed, 17 Jan 2007 11:22:22 -0800 (PST)
To: "Nikolai Weibull" <now@bitwi.se>
User-Agent: KMail/1.9.3
In-Reply-To: <dbfc82860701171008r65006b60vf81df9f82ab25712@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37027>

Nikolai Weibull wrote:

> I maintain the git completion-definition for Zsh.

Could you add it to contrib/completion/ or at least put link
in http://git.or.cz/gitwiki/InterfacesFrontendsAndTools ?

TIA
-- 
Jakub Narebski
Poland
