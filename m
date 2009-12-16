From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 6/6] GITWEB - Separate defaults from main file
Date: Wed, 16 Dec 2009 20:52:08 +0100
Message-ID: <200912162052.09470.jnareb@gmail.com>
References: <1260488743-25855-1-git-send-email-warthog9@kernel.org> <7v8wd3ww4d.fsf@alter.siamese.dyndns.org> <4B283F3D.3020209@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
To: "J.H." <warthog9@kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 16 20:52:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKzvO-00020s-C1
	for gcvg-git-2@lo.gmane.org; Wed, 16 Dec 2009 20:52:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751901AbZLPTw0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2009 14:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751899AbZLPTwZ
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Dec 2009 14:52:25 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:33630 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751473AbZLPTwX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2009 14:52:23 -0500
Received: by bwz27 with SMTP id 27so1050523bwz.21
        for <git@vger.kernel.org>; Wed, 16 Dec 2009 11:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=1rCZA8gC3Ux3oNgDlFCGnHMbjLD6Ft+XIEusXHMgatk=;
        b=YVbto345oHPTfLbPwm6SZCqLTp00dl4In5r/2VhWGQGG2f778KqX8wI1GYtENL/Dcr
         sdq88+TdWZXiLKSdgOdG+XO9dpo8oRZgbNKxmV6lFWBQwCA8EAy55UwOMMiszViUShcH
         Jmf3CSl0G/D5kr0ersb8COfQnkE+9vH7qigxE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=kYA6U8JyRmk2KiI0dtwSwC5snmci4HlIapf7E6eEVBuSCpmwxyF/txxI6q7hGrGnlB
         OfRvlxkBdw2F95IOLGZTSwJCIJVmTAbkD6YlOoauuTNksXRc3wtWXDWkYUj5JoHsrHcf
         hCQdO/RojYDWCBM6zCsnTghDcPz5aqiFB3ptw=
Received: by 10.204.153.217 with SMTP id l25mr806376bkw.108.1260993139873;
        Wed, 16 Dec 2009 11:52:19 -0800 (PST)
Received: from ?192.168.1.13? (abva156.neoplus.adsl.tpnet.pl [83.8.198.156])
        by mx.google.com with ESMTPS id 16sm392165bwz.7.2009.12.16.11.52.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 16 Dec 2009 11:52:15 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <4B283F3D.3020209@kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135337>

On Tue, 15 Dec 2009, 18:00 -0800, J.H. wrote:
> Junio C Hamano wrote:

> > Any progress on this front?
> 
> Sadly, no.  Busy weekend and a need to get some of the kernel.org 
> servers upgraded has taken some precedence.  I should be circling back 
> around on this tomorrow I think.

So should I wait for reroll with proposals for improvements (modified 
patches)?

-- 
Jakub Narebski
Poland
