From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Remove gitweb/test/ directory
Date: Sun, 1 Jun 2008 03:59:42 +0200
Message-ID: <200806010359.43264.jnareb@gmail.com>
References: <28EDBE43-6E55-4EC9-97C6-8AC8D949E82D@zib.de> <20080531182555.1646.47950.stgit@localhost.localdomain> <7v7idadkv0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Kay Sievers <kay.sievers@suse.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 01 04:00:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2csC-0006p0-Ee
	for gcvg-git-2@gmane.org; Sun, 01 Jun 2008 04:00:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755267AbYFAB7r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2008 21:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755265AbYFAB7r
	(ORCPT <rfc822;git-outgoing>); Sat, 31 May 2008 21:59:47 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:13918 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755257AbYFAB7q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2008 21:59:46 -0400
Received: by nf-out-0910.google.com with SMTP id d3so226572nfc.21
        for <git@vger.kernel.org>; Sat, 31 May 2008 18:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=N+dNn5rS6J/7j1TvMjQTF6BNDKc8tMj1Qp59ViseexU=;
        b=pFwUP+lxcDmKcvP54/W/pCo9HOhCUBUfyGPPv8d0R5mv9nA+GRFukcRYO2zt+eB6O8IzssI5Sb006GZRKmwiGp2N8l5HSmpPMHGelpYdGWn9vPsRbVNnlw5u3RRURmEA/veG5tWB/AvzM2TopZkS9u6KkH069/7EFaJTeUIHzqU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Uk5vxUCBSvoprjHE0y86UTTAi0Ts4Qtu/ToFX6MMtbu5aolAogphojUvOelJzoog6hHMcQOiaZwbyGRE3CXqi0GTmjfTmSvTt9gb3vssGcSi5UJfHM9D9s6/7KHo2Ra42FnXxFCM4PRr+Cv8EKlg5qSE8tjEuSbC4r4uImmaMGc=
Received: by 10.210.63.6 with SMTP id l6mr4005597eba.153.1212285584409;
        Sat, 31 May 2008 18:59:44 -0700 (PDT)
Received: from ?192.168.1.15? ( [83.8.204.14])
        by mx.google.com with ESMTPS id i7sm16004040nfh.8.2008.05.31.18.59.42
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 31 May 2008 18:59:43 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7v7idadkv0.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83421>

On Sat, 1 Jun 2008, Junio C Hamano wrote:

> I do not think Kay minds, but it would not hurt to give him a courtesy
> copy of this before finally applying such a patch.

Done.
-- 
Jakub Narebski
Poland
