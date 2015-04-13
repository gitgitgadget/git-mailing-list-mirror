From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3] CodingGuidelines: update 'rough' rule count
Date: Mon, 13 Apr 2015 10:30:02 -0700
Message-ID: <20150413173002.GC5467@google.com>
References: <20150412234720.GA37658@Serenity.local>
 <CAPig+cS=xBoe-hr5Kwm0N9hBUy4bzN1NoXTcDEwz_4ZwrrXPXA@mail.gmail.com>
 <20150413042644.GA39596@Serenity.local>
 <CAPig+cTgNzO5NGabOsaSZOq7Y47OBXJz9mnS-MfpoQ2MANzrng@mail.gmail.com>
 <CAPig+cQ3z_UuUMZE_jUGbv1_3Fu_32GSw2ysSixw4VE0opz27w@mail.gmail.com>
 <20150413125414.GA1038@Serenity.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
To: Julian Gindi <juliangindi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 13 19:30:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhiBX-0005OW-LO
	for gcvg-git-2@plane.gmane.org; Mon, 13 Apr 2015 19:30:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbbDMRaG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2015 13:30:06 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:34860 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932343AbbDMRaF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2015 13:30:05 -0400
Received: by igbyr2 with SMTP id yr2so16410098igb.0
        for <git@vger.kernel.org>; Mon, 13 Apr 2015 10:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=oDESnFLBCib3KM7l/EM6Tai5qjKLxI6g6Z+jlthVzm4=;
        b=R1gPDguItNPqQT1yKvAwuPzZtODy9qgL7ggAPx1uPAOzmHLBYSvSpdjicmEc3yhNvY
         9JQxRa4ZvTKvhMLkZuDGteqe/krdvNYaAtEsdnKLK+ZG92nTwfBX1Ygx+2wB8EbQrELt
         h9Wx/w0cXZClD/NYYeT/dxNybgtMlqa5sAXMRKgPNoV78vCw9J8zb0e5Y308eSuarkNj
         8qEQm3DN52TpEXg3izimVuTTWpnOc/fGv08m6Zlj/0XNj+AGEpCLohhGS1movR+gGOkV
         0KouFLzJeGx4I3X0t+WRB7u4o9xTetjRr+/t9Xp1TAsiqfj25nwMxwkVQjr0CXPbiKTm
         c94A==
X-Received: by 10.50.35.195 with SMTP id k3mr18354426igj.11.1428946205067;
        Mon, 13 Apr 2015 10:30:05 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:ed10:7b5c:963e:5b26])
        by mx.google.com with ESMTPSA id 7sm5271702iol.43.2015.04.13.10.30.04
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 Apr 2015 10:30:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150413125414.GA1038@Serenity.local>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267097>

Julian Gindi wrote:

> Changed inaccurate count of "rough rules" from three to the more
> generic 'a few'.
>
> Signed-off-by: Julian Gindi <juliangindi@gmail.com>

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
