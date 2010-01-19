From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Branch merge bug
Date: Tue, 19 Jan 2010 18:52:16 +0530
Message-ID: <f3271551001190522h37dd639k1352d54c1c07496f@mail.gmail.com>
References: <f3271551001182322p86a02d8p8b9ceb49e930d333@mail.gmail.com> 
	<4B55A080.7010705@drmicha.warpmail.net> <20100119123915.GB28667@inner.home.ulmdo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 19 14:22:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXE2b-0005XG-Uk
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 14:22:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752203Ab0ASNWi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 08:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751590Ab0ASNWh
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 08:22:37 -0500
Received: from mail-yw0-f182.google.com ([209.85.211.182]:40331 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751489Ab0ASNWh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 08:22:37 -0500
Received: by ywh12 with SMTP id 12so2411496ywh.21
        for <git@vger.kernel.org>; Tue, 19 Jan 2010 05:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=hTj+3KptLronTcLvaXwR8WxqKPTjB8t9SZy7F8iA8vA=;
        b=g7/sxuKlKXRUEfXEl80FUcm6gulBqaL97BhqJsChnXlQINV3SxvwsDsHHoksMH3NIl
         1jJAVXJFLtJv3185KV+ycq82iI+k7K1W4BQ062oDA1VJeNUI5MJtqWTm1lNW4ALEnWC9
         +0IQnZaMB89wnnrTgjEsjcHHrNu7yEhjWwpLE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=MzTJ6hjAPqVEtyykVaUbiiRG3DnzPVOlEZGTeC4k54oyMwMUD72FYnHVgxW3sdiSh9
         aj4JJ6+LQuGoXMXKWBi+Z5U1482kp/ifITSirJ2+A98oBOMe6QIiWEMkczgIIdE7msxM
         0SMSSv2ib2BDFQu9kK8GiLlmOZkduOlLWU2b0=
Received: by 10.91.215.7 with SMTP id s7mr6667546agq.81.1263907356298; Tue, 19 
	Jan 2010 05:22:36 -0800 (PST)
In-Reply-To: <20100119123915.GB28667@inner.home.ulmdo.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137456>

Right. Thanks for clearing that up for me.
