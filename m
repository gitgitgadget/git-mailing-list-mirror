From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: v1.5.4 plans
Date: Sun, 02 Dec 2007 14:33:51 -0800 (PST)
Message-ID: <m33aukwwtx.fsf@roke.D-201>
References: <7vk5nwu51x.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 02 23:34:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyxOD-0005FE-QC
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 23:34:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbXLBWd6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 17:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbXLBWd6
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 17:33:58 -0500
Received: from mu-out-0910.google.com ([209.85.134.190]:2856 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751091AbXLBWd5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 17:33:57 -0500
Received: by mu-out-0910.google.com with SMTP id i10so148058mue
        for <git@vger.kernel.org>; Sun, 02 Dec 2007 14:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=M2tFJpooBNZiGlwly6uL804SsxjJUr1adX9xJ2NXLR8=;
        b=d8ph+Wz5HOXTdAa9Vq4BhlAgl8YeYtmJOr6uXrkdy897zg3f6fFGX53d2VYiHyTEe4MjXjozHBVS3UTSeZK9Tu5kKe6QVP6H4pcaNJ03pKNUcMTlRjBWA7CUqRozCiBHTxSavGxkrF8uPQ3FjfAyA9zTtRM2gnZ3BKuBB2Y50h4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=YhQf0vNmFhGG3+aJ7ofp9u63LPd5P7WHiz5y07ZDoyLP0LHGeqU4vUjhIZ7nI5zIxUu5VSrONe/aqSyMR18wGqgsam8HlV35wD6XcFHkUA0dvBaocsH75dCrGR7CfVFY+AC4bbOaRO1qTU/cUHgD9DUfHfvzRPsT8pn0BoDyMQg=
Received: by 10.86.80.5 with SMTP id d5mr9893921fgb.1196634832986;
        Sun, 02 Dec 2007 14:33:52 -0800 (PST)
Received: from roke.D-201 ( [83.8.251.146])
        by mx.google.com with ESMTPS id d4sm3943813fga.2007.12.02.14.33.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 02 Dec 2007 14:33:51 -0800 (PST)
Received: from roke (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lB2MXk3P001042;
	Sun, 2 Dec 2007 23:33:46 +0100
Received: (from jnareb@localhost)
	by roke (8.13.4/8.13.4/Submit) id lB2MXk28001039;
	Sun, 2 Dec 2007 23:33:46 +0100
X-Authentication-Warning: roke: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <7vk5nwu51x.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66828>


Does this mean we should be entering feature freeze?
Or at least feature freeze for 'master'?

-- 
Jakub Narebski
