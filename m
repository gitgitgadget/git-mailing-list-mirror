From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: [ANN] codeswarm.rb v1.0
Date: Mon, 17 Nov 2008 01:29:00 +0200
Message-ID: <94a0d4530811161529i1ac9b1dep42afd1a013af894b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Peter Burns" <rictic@gmail.com>
To: "Ruby Talk" <ruby-talk@ruby-lang.org>,
	"git list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 17 00:30:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1r4L-0008Pz-Rm
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 00:30:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753938AbYKPX3B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2008 18:29:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753902AbYKPX3B
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Nov 2008 18:29:01 -0500
Received: from rv-out-0506.google.com ([209.85.198.229]:16163 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753835AbYKPX3B (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2008 18:29:01 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2176805rvb.1
        for <git@vger.kernel.org>; Sun, 16 Nov 2008 15:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=7Fa/SZvR7m79WDpVEbCIldh2tizrEHVbiLmgW/pVH0g=;
        b=BcuPI8jrSJ94OuN0yH527ijug6D35gzrD9nd0/ePm3+w63otQfW1L7PzOr8POSaL+z
         afbYnLhjBQxe4peCjfoMehHpjA5R53sP2MkbckBQC/e+1XzxwJmyh+ysWALX3+sEJHmk
         kKjpMcnGZIRGs/Fx1H30OL8YoG0k80U/IrTNI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=RRngHj9ueDqvcsDdhLjX3F1BcFpgGN1M/LOF2+90NP2+m+Qiq9DXNUQ1choFnEHhgw
         Zpg2xUz3tJ/BeTlamEn9wToYpmuwsKX4k3rWAsn0bvRzTGWWHKw+nTQCfNlNnDJVi/7p
         o91iqV653k6WHad91RxJfr9qeNSD3SLmYoeJA=
Received: by 10.141.68.12 with SMTP id v12mr1886295rvk.228.1226878140274;
        Sun, 16 Nov 2008 15:29:00 -0800 (PST)
Received: by 10.140.166.19 with HTTP; Sun, 16 Nov 2008 15:29:00 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101171>

Hi,

codeswarm.rb is a rewrite of Michael Ogawa's code_swarm in ruby using cairo.

For an example see:
http://www.youtube.com/watch?v=PxjLbj8oT1k

For the original code:
http://code.google.com/p/codeswarm

The format of the events xml file is compatible with code_swarm's one,
and the physics engine is basically the same.

The code is less than 500 lines of code, so it should be fairly hackable.

http://github.com/felipec/codeswarm.rb

Enjoy :)

-- 
Felipe Contreras
