From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCH] Documentation: push.default applies to all remotes
Date: Tue, 24 Mar 2009 10:39:17 +0100
Message-ID: <adf1fd3d0903240239l7997b77dw24ee304659f70d44@mail.gmail.com>
References: <1237850318-3671-1-git-send-email-santi@agolina.net>
	 <7v7i2f6cj7.fsf@gitster.siamese.dyndns.org>
	 <20090324083015.GA22271@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Tue Mar 24 10:41:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm38R-0001Ac-Er
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 10:41:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757827AbZCXJjV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 05:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757585AbZCXJjV
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 05:39:21 -0400
Received: from mu-out-0910.google.com ([209.85.134.190]:11650 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757180AbZCXJjU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 05:39:20 -0400
Received: by mu-out-0910.google.com with SMTP id g7so893263muf.1
        for <git@vger.kernel.org>; Tue, 24 Mar 2009 02:39:17 -0700 (PDT)
Received: by 10.102.247.4 with SMTP id u4mr3512092muh.128.1237887557305; Tue, 
	24 Mar 2009 02:39:17 -0700 (PDT)
In-Reply-To: <20090324083015.GA22271@pvv.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114443>

Hi,

  one thing I wonder is if push.default is too generic, maybe
push.style matches more the meaning.

Santi
