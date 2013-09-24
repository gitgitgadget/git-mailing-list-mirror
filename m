From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] doc: don't claim that cherry-pick calls patch-id
Date: Tue, 24 Sep 2013 15:53:56 -0700
Message-ID: <20130924225356.GW9464@google.com>
References: <1380060333-2226-1-git-send-email-mst@redhat.com>
 <20130924221409.GT9464@google.com>
 <20130924222822.GA2308@redhat.com>
 <20130924224431.GU9464@google.com>
 <20130924225203.GA2521@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Wed Sep 25 00:54:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VObUc-0004wh-KI
	for gcvg-git-2@plane.gmane.org; Wed, 25 Sep 2013 00:54:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754041Ab3IXWyC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 18:54:02 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:47010 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753899Ab3IXWyB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 18:54:01 -0400
Received: by mail-pb0-f53.google.com with SMTP id up15so5153309pbc.26
        for <git@vger.kernel.org>; Tue, 24 Sep 2013 15:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=8c/kg/XQ2ySizwwgmt68NddOCPSyZWgp7Rl4z/LWQqw=;
        b=hXyi6DF5siZodNdraqEHR2v1TdmUnoXsigiyBruZCFJbz17AB4OVQGZ1nJsqhPoIAu
         hLQYdSn9CDayFdMPwQpcs1e1jeH/o+SP1UelTGGMj1a6kzDqcZp6LrNja7uU0SfscUST
         tpQHm2A28eMR9l0NrlTo3AWUgItW0ymbBlwpoGdvg+SvgcRO4TphzKNU3eS7QzuePYeM
         MGii8oDauWU5H+korqtXJ4O5EKSRC9XIMbBrl+cbic3cZs0YyFtquNmXf9+IGT0viDc0
         y0Rwf6YrsaGztbuaYkRDkutkdONEda0J9Oy/Vb2/SX8IiGkm6+oxgSG0GzK6SL1g+3td
         E9Ig==
X-Received: by 10.66.145.4 with SMTP id sq4mr7638067pab.178.1380063240626;
        Tue, 24 Sep 2013 15:54:00 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id iu7sm43253194pbc.45.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 24 Sep 2013 15:53:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130924225203.GA2521@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235327>

Michael S. Tsirkin wrote:

> See v2 that I sent, maybe that's clear enough.

Yep, looks sensible.  Thanks.
