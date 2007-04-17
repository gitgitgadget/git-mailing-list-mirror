From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Weird shallow-tree conversion state, and branches of shallow trees
Date: Tue, 17 Apr 2007 10:45:19 +0100
Message-ID: <200704171045.20897.andyparkins@gmail.com>
References: <20070412005336.GA18378@curie-int.orbis-terrarum.net> <200704161003.07679.andyparkins@gmail.com> <Pine.LNX.4.64.0704160814300.5473@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Robin H. Johnson" <robbat2@gentoo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 17 11:45:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdkFe-0003zF-Lb
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 11:45:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753141AbXDQJp1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 05:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753154AbXDQJp1
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 05:45:27 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:37168 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753141AbXDQJp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 05:45:27 -0400
Received: by ug-out-1314.google.com with SMTP id 44so124565uga
        for <git@vger.kernel.org>; Tue, 17 Apr 2007 02:45:25 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=YdTtGp7v9EfJfMLQYxQWq9MaifisB9J0eVMxUaJSjBKzQpvjzdyH3m4olwsx1SmWZSigKc6PjjuCSJzYxyQBP/HhTLBc23tdPwy5Y2JiqniQ/ABohVx/LfcByB+kOa+uStsZzZ2lpuHXuJXo+PpnKUSNn1Tb5f0cngQqv1YxFZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=MmqTDRzRVqsn8M3eA80OEVGhimU36rfosuw4zaPR5yXuhkwyDkBA7SqdfrrgaYFLtwawww8F0hNJ1Ci+O/F7chqoNDLMJpdROWAHBBuOevcDHaVFtV6QKVzicTrb4TKHV9AY32bQkUb8euybGsbS845sDuWSYS1ReKkSPWoPCKI=
Received: by 10.82.147.6 with SMTP id u6mr441852bud.1176803124217;
        Tue, 17 Apr 2007 02:45:24 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id c22sm2245687ika.2007.04.17.02.45.22;
        Tue, 17 Apr 2007 02:45:23 -0700 (PDT)
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.64.0704160814300.5473@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44751>

On Monday 2007 April 16 16:58, Linus Torvalds wrote:

Thank you for the detailed response.  My apologies for the delay in replying, 
I did write and send a response, but it's gone missing in the world of 
google's SMTP server.  I'll try and resend when I return home.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
