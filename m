From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2013, #08; Wed, 25)
Date: Fri, 27 Sep 2013 10:52:58 -0700
Message-ID: <20130927175258.GK9464@google.com>
References: <20130925234121.GD9464@google.com>
 <8BE13DA6F1DE41A5A17355D7F98D40D8@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Sep 27 19:53:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPcE0-0003L3-7z
	for gcvg-git-2@plane.gmane.org; Fri, 27 Sep 2013 19:53:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753451Ab3I0RxE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Sep 2013 13:53:04 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:37957 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753424Ab3I0RxD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Sep 2013 13:53:03 -0400
Received: by mail-pd0-f178.google.com with SMTP id w10so2920285pde.9
        for <git@vger.kernel.org>; Fri, 27 Sep 2013 10:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=joCajaGxQFCuXJB94sNqn2srvygy6d/1ldqyt0KayxA=;
        b=LPcu1aA49Sa/ZQIjgd3EmKb099V+fHz1HiiVomZ64YNY3HZw4e62yKcEhX1ljCB33M
         liODha3JSQAcmR3nUnMar0eSW24YkK0GqK8t7CcvkLkn6hstt+m7H9TS9WB3iB2XBARc
         aq/ET2mTvc0KGBCeo3KCgwxVUNnjnbHt+St1quneNhe24k4d3X8vl8YYLDbxG4rVSPeE
         2ehEHfQXZUFW18wv3rb51gi1riBQQfhEyohLbgcTNAx5+uZ7EImSCgHxvFZEYFaGAadd
         SkRIraT00OVeNONe088jfmzuz9B6eW/e7gd2289Q8sIBoUlz7MWJgNAvLI2H/MplEc2D
         O9aw==
X-Received: by 10.66.136.131 with SMTP id qa3mr12886388pab.77.1380304382443;
        Fri, 27 Sep 2013 10:53:02 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id fi4sm10119502pbc.28.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 27 Sep 2013 10:53:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <8BE13DA6F1DE41A5A17355D7F98D40D8@PhilipOakley>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235471>

Philip Oakley wrote:

> Jonathan,
> Did you spot my recent
> http://thread.gmane.org/gmane.comp.version-control.git/235127?

Will take a look.  Thanks.
