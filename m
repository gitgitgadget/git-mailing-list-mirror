From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH 6/7] Remove unused and bad gettext block from git-am
Date: Sun, 22 Jul 2012 09:33:44 +0800
Message-ID: <CANYiYbEofo=NrEZ5g7TZpunBsmXMCJFVdkufY5uAOGPgbVTn5Q@mail.gmail.com>
References: <cover.1342884458.git.worldhello.net@gmail.com>
	<a7d2248051ddc62e38e67d9efbb41c01498c7a4c.1342884459.git.worldhello.net@gmail.com>
	<0fd901035a418562d3d9282553a96124814a298a.1342884459.git.worldhello.net@gmail.com>
	<77cbbce0450735a66ef1d9101af0bc82e3fc545c.1342884459.git.worldhello.net@gmail.com>
	<941f7bd695e8a14c940a5b8e4214d2773ae82557.1342884459.git.worldhello.net@gmail.com>
	<d5c4000b859f4b30af6fc3faec008403b82246bf.1342884459.git.worldhello.net@gmail.com>
	<d1af1d40b0edbb8e356ecbb700cd0a7c13832a8f.1342884459.git.worldhello.net@gmail.com>
	<500AD8F2.1000101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 22 03:34:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ssl3a-0004zY-Fl
	for gcvg-git-2@plane.gmane.org; Sun, 22 Jul 2012 03:34:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752036Ab2GVBdp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jul 2012 21:33:45 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:59668 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751715Ab2GVBdo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2012 21:33:44 -0400
Received: by obbuo13 with SMTP id uo13so7206957obb.19
        for <git@vger.kernel.org>; Sat, 21 Jul 2012 18:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3D6jQRTMe+53ZfGDwTR6SHzbkZIBIpe6R64FOStbodk=;
        b=Y22fUo0gAyIZqXK1YYOWiNoeqWQG8QPPSSWPQ0ZTZzJgQXnmoXrz8o3ALcaS48y9pj
         vJfcyI7koKfDW5MV1Cilg1uW/XCIayBPGCBYjAWRdEOgv1RpjrtB30SoU3xiUK0lebGI
         qESAhyD/ESBfUrBWIs/vvTy5tUf9F4Yyj4GtAs6jeoMEuLLX/W5Qdb8minAfBIk1avbI
         7zkyJqIRPnIBACkbCqoTg6mOpJMX+oTi5ojsro0v3u6ajh2MtvNsysxZa3VpzdE0fDNv
         wijL6bSpDh0uD0/3Vdnn2h9j+8XbDZoqEHAexLJW2OynU1s+5btRE+PNiQ3ZDZ2YYGIo
         S/tw==
Received: by 10.50.89.130 with SMTP id bo2mr7730490igb.19.1342920824172; Sat,
 21 Jul 2012 18:33:44 -0700 (PDT)
Received: by 10.50.237.38 with HTTP; Sat, 21 Jul 2012 18:33:44 -0700 (PDT)
In-Reply-To: <500AD8F2.1000101@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201841>

2012/7/22 Stefano Lattarini <stefano.lattarini@gmail.com>:
> s/message/messages/ I think.
> s/are not/do not/
> This "so" is redundant, in light of the earlier "Since".  I'd just remove it.

Thanks, Stefano. New series of patches are generated and sent to this list.

-- 
Jiang Xin
