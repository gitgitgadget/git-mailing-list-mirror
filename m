From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 0/3] git-remote-fd & git-remote-ext
Date: Mon, 4 Oct 2010 06:30:43 -0500
Message-ID: <20101004113043.GE4738@burratino>
References: <1286190258-12724-1-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Mon Oct 04 13:34:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2jJ3-0007zm-8P
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 13:34:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754711Ab0JDLeB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 07:34:01 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:55857 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754076Ab0JDLeA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 07:34:00 -0400
Received: by qyk29 with SMTP id 29so160109qyk.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 04:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=JUb6rv2QKx6G67747X+iONEeRKtqHXZ8tkXBYgKsSzM=;
        b=vX7Cy/qO95X2a/o7bqYZD5CcqKroOUq7ikVsSCsECVudNcMAZznxthlOfF7QEdrsBS
         xGJw8b2GPiSIBL1+ptA0fdAprJsXPNaL0Q2WJpBzHhhVVJZBkDJxBP5G9C2uT0rhmwmo
         x/+DdWbIQKs+KlF555q5OEztNrK4cFzEoe9R8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=plIKqF9abJU7Xet1ykJcfwgPZIFq9d13pg/K8dCKUVuSx22yXVwVF4vaZNCMzyK3/5
         ZwUKK3Q9DMBQ4rHvFYE/wKGkqAPN2xhdMktbMq2bHx5FHwMY4CFCxteVgw39Ac/AXZYv
         w36slhENfKDqQBeEWOGdKGD1WuTyP/FoZeMSk=
Received: by 10.229.225.10 with SMTP id iq10mr3323567qcb.236.1286192038872;
        Mon, 04 Oct 2010 04:33:58 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id r36sm5431182qcs.3.2010.10.04.04.33.57
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 04:33:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1286190258-12724-1-git-send-email-ilari.liusvaara@elisanet.fi>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158033>

Ilari Liusvaara wrote:

> This adds two new remote helpers.

Looks good to me.  I assume you've checked it still works. :)
