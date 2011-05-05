From: Rowan Lewis <me@rowanlewis.com>
Subject: Re: Filemode is a nuisance
Date: Thu, 5 May 2011 13:41:28 +1000
Message-ID: <54F344CF18124A8D8D1D3DE5E4484736@rowanlewis.com>
References: <5B76586FBEB246BDA2F097E21C78E881@rowanlewis.com>
 <86k4e5al4s.fsf@red.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 05 05:41:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHpRd-0000Ym-4U
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 05:41:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752633Ab1EEDlg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 23:41:36 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:40845 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752596Ab1EEDlf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 23:41:35 -0400
Received: by pzk9 with SMTP id 9so787922pzk.19
        for <git@vger.kernel.org>; Wed, 04 May 2011 20:41:33 -0700 (PDT)
Received: by 10.68.40.164 with SMTP id y4mr2615963pbk.291.1304566892971;
        Wed, 04 May 2011 20:41:32 -0700 (PDT)
Received: from rowan.sites.randb.com.au ([203.144.8.51])
        by mx.google.com with ESMTPS id a1sm1144881pbo.91.2011.05.04.20.41.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 04 May 2011 20:41:32 -0700 (PDT)
In-Reply-To: <86k4e5al4s.fsf@red.stonehenge.com>
X-Mailer: sparrow 1.1.2 (build 688.7)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172791>

If you want to deploy, write the proper deploy tool that sets the permissions.
It would be nice to; but unfortunately I cannot, and it would only solve the case where we deploy to the production server.

Not being able to disable filemode will still be a nuisance a lot of the 
