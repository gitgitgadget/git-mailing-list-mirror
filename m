From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] gitk: use symbolic font names "sans" and "monospace"
 when available
Date: Sun, 18 Mar 2012 23:53:18 -0500
Message-ID: <20120319045318.GB25237@burratino>
References: <20120308123011.GA4355@burratino>
 <20120318232503.GG26977@bloggs.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pat Thoyts <patthoyts@users.sourceforge.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Mark Hills <mark@pogo.org.uk>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Mar 19 05:53:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9Ub6-0001zk-KV
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 05:53:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753023Ab2CSEx1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Mar 2012 00:53:27 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48384 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752543Ab2CSEx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2012 00:53:27 -0400
Received: by iagz16 with SMTP id z16so8914629iag.19
        for <git@vger.kernel.org>; Sun, 18 Mar 2012 21:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=JFey8iJMReYebbMkyTtVM8rP1y3/vQICqXM7taodlEQ=;
        b=NA3nrZbIbvQAFU0jjjJrQVlPKuqlWcCSM0ShO7omE6xnrOGlj9nLYkYYYy7ZyylWou
         1xgOqXTcHnpLKq4fa/4OPaMWx0Tqk+8lBgfGDDxs4ShzhcRPyGKaNOobIs4TceXYCpmG
         Egf4PoMTWpXrYPnfAY0iDJ+U4vDqXIJ3SBflRd0BfHqDlLOetR9usUMsIamWwIizsMj9
         p/QnASVcCabik3wRrp/Sk5Mdy8EE8RuFHFQVSFoQn+4AZ6Q+3AD/wdVO24Whp1dLGr/I
         yj6qWN3SBwY7qP4BXESYCPeI1wbo6sAT5IZJIQ22QdqFoP+bbJc5Zag93DTTn9G1Nqu2
         z5Dg==
Received: by 10.50.17.226 with SMTP id r2mr4894601igd.67.1332132806600;
        Sun, 18 Mar 2012 21:53:26 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id cu4sm7701931igc.15.2012.03.18.21.53.25
        (version=SSLv3 cipher=OTHER);
        Sun, 18 Mar 2012 21:53:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120318232503.GG26977@bloggs.ozlabs.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193414>

Paul Mackerras wrote:

> Thanks, applied.

Thanks to all of you for looking it over.
