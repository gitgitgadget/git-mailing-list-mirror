From: Johan Herland <johan@herland.net>
Subject: Re: merging .gitignore
Date: Wed, 3 Oct 2007 15:06:23 +0200
Message-ID: <200710031506.23938.johan@herland.net>
References: <20071001130314.GA5932@lapse.madduck.net> <200710031128.56472.johan@herland.net> <Pine.LNX.4.64.0710031314530.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andy Parkins <andyparkins@gmail.com>,
	martin f krafft <madduck@madduck.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 03 15:07:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Id3wQ-0007YM-RA
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 15:07:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754486AbXJCNGr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 09:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754451AbXJCNGr
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 09:06:47 -0400
Received: from sam.opera.com ([213.236.208.81]:52610 "EHLO sam.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754334AbXJCNGq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 09:06:46 -0400
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	by sam.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id l93D6OFe024967
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 3 Oct 2007 13:06:24 GMT
User-Agent: KMail/1.9.7
In-Reply-To: <Pine.LNX.4.64.0710031314530.28395@racer.site>
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.91.1/4461/Wed Oct  3 08:50:48 2007 on sam.opera.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59835>

On Wednesday 03 October 2007, Johannes Schindelin wrote:
> On Wed, 3 Oct 2007, Johan Herland wrote:
> > - Teach the .gitignore parser to ignore conflict markers (i.e. regard them 
> > as comments)
> 
> You might be delighted to know that in practice, it works already (because 
> you usually do not have a file named "<<<<<< blablub" or "======" or 
> ">>>>>> blablub"...

I suspected so... ;)


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
