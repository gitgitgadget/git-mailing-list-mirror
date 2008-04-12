From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH v3 4/4] buitin-status: Add tests for submodule summary
Date: Sat, 12 Apr 2008 23:13:41 +0800
Message-ID: <46dff0320804120813w36da1c9bi4c480849b53895c0@mail.gmail.com>
References: <1208012733-18211-1-git-send-email-pkufranky@gmail.com>
	 <1208012733-18211-2-git-send-email-pkufranky@gmail.com>
	 <1208012733-18211-3-git-send-email-pkufranky@gmail.com>
	 <1208012733-18211-4-git-send-email-pkufranky@gmail.com>
	 <1208012733-18211-5-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Ping Yin" <pkufranky@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Apr 12 17:14:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkhQx-00069l-1v
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 17:14:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752812AbYDLPNn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2008 11:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752788AbYDLPNn
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Apr 2008 11:13:43 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:13497 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752624AbYDLPNm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2008 11:13:42 -0400
Received: by an-out-0708.google.com with SMTP id d31so223526and.103
        for <git@vger.kernel.org>; Sat, 12 Apr 2008 08:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Dyh9MmU43Ni2s9RowtYl4TxfsJUgfE++hL6rfvhp1bY=;
        b=pNNFNW6/DwZy3znlZMFIRkiuf7EkEw/f1IpWTjyvb7wNz9uVd3nwlLSKbbasq44cTsjah4c1YJKz/buKb1icYe3pB62O7ALDUEiSMLye4gl6jDCIVYl5Swrv7YeYqneey3O56BJjbrUo5eRjcpz6OImtLYp1+xXqY3YdydanBZc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=btLXsYwKof564L7POOFcbWl2GNtF2hV8xMwSIGTiSqkL7cA5SW9V3nxLtp2NLkuf1QeVCz977SpywGFOCzxfFzfXhwDc7FeuEdBeurSaHR1F4X5RJS/t2JO81h4BxSDE5NWwNYjYqRScOkE1VcQU1ygTuV2pGKJlTfWuKTBlO14=
Received: by 10.101.70.5 with SMTP id x5mr7952747ank.93.1208013221627;
        Sat, 12 Apr 2008 08:13:41 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Sat, 12 Apr 2008 08:13:41 -0700 (PDT)
In-Reply-To: <1208012733-18211-5-git-send-email-pkufranky@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79362>

s/buitin/builtin/ in the title


-- 
Ping Yin
