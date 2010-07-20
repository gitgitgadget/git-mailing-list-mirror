From: Jared Hance <jaredhance@gmail.com>
Subject: Re: [PATCH 0/2] Add -e/--exclude to git-clean.
Date: Tue, 20 Jul 2010 15:43:54 -0400
Message-ID: <20100720194353.GA5772@localhost.localdomain>
References: <cover.1279654370.git.jaredhance@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 20 21:44:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObIjb-0000lk-85
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 21:44:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754309Ab0GTToG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jul 2010 15:44:06 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:35317 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752609Ab0GTToC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jul 2010 15:44:02 -0400
Received: by gwj18 with SMTP id 18so2930709gwj.19
        for <git@vger.kernel.org>; Tue, 20 Jul 2010 12:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=bm1HuapaQfWsggBrP1Y3be5KP9QkxnvJQQZ/BG8dB3Q=;
        b=HNlmHjIaWsWTlMNM4sUJQe1KCnVQcdtkGczaAGGdVVp5iP5P10KLbr+c/Kirkt9MU1
         0sKc0cgyRXLmrC7qlVfennvVQQf2jxdBs16DafGD4xeFwoBt2Utlib61hnfT6aGLy8Mq
         jC2WOw0cLBVHKVfEzLdUwYxzPMiACwxt8vk2M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=oIj7cMXC9ifq3ni4CphzCupVQmVv/C/ziDF0nfSjc5LmKUpFI8cUjZX+i1tDNuotFo
         hzFJdtN3f3dCNpeg7/tpI9Ufz8zq/WjL9qh2phTY3mcnIv7WU1gOKdblurp2Pot1ka1J
         6cM/LhJyJ9XXk50ASLGG1RuEmB77JWI81a2ko=
Received: by 10.224.27.104 with SMTP id h40mr6093242qac.125.1279655041476;
        Tue, 20 Jul 2010 12:44:01 -0700 (PDT)
Received: from localhost.localdomain (cpe-75-186-1-50.cinci.res.rr.com [75.186.1.50])
        by mx.google.com with ESMTPS id j28sm28346151qck.47.2010.07.20.12.44.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 20 Jul 2010 12:44:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <cover.1279654370.git.jaredhance@gmail.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151358>

My apologies, please:
    %s/Julio/Junio/g
